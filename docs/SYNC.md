# Offline-first sync

The local SQLite database is the source of truth for the UI. Cloud sync is
optional, per profile, and off by default. Code: `lib/features/sync/`.

## What syncs

Chosen per category by the user (all off until enabled):

| Category | Tables |
| --- | --- |
| Always, when sync is on | `user_preferences`, `achievement_awards`, `daily_plans`, `planned_activities` |
| Study | subjects, syllabus topics, exams, study sessions, flashcards, flashcard reviews |
| Fitness | water logs, fasting sessions, workout sessions |
| Prayer (private by default) | prayer settings, prayer records |
| Journal (private by default) | journal entries |

**Never synced:** profile identity (name, recovery question and verifier,
cloud id), notification preferences, privacy and consent preferences, AI
conversation history, and anything not listed. Consent is per device and must
never be copied by sync.

## Identity

The local profile id is never used to authorize anything remotely. A synced row
is stored under the signed-in user's id (`auth.uid()`) chosen by the server from
the JWT. Rows carry a `@profile` placeholder instead of the local profile id,
so a second device with a different local profile id receives the data under
its own profile.

## Protocol

One cycle is *push, then pull*.

**Push.** For each synced table (in dependency order) rows whose change column
(`updated_at`, or the event time for append-only rows) is >= the stored
per-table cursor are sent in batches of 100. Deletions are sent from the
`sync_tombstones` table, which database triggers fill whenever a synced row is
deleted (including cascades). Tombstones are removed only after the server
acknowledged them. Pushes are idempotent: the key is (table, row id).

**Pull.** Records with `seq > cursor` are fetched in pages of 200, ordered by a
server-assigned, strictly increasing sequence number. The cursor is the last
`seq`, not a timestamp, so device clock skew cannot make changes invisible. A
page is applied in one transaction, upserts parent-first and deletes
child-first.

## Conflict rules

| Data | Rule |
| --- | --- |
| Mutable rows (settings, subjects, topics, cards, journal, plans, sessions, fasts) | Last writer wins by the row's own `updated_at`. On a tie the local row is kept. Not merged field by field. |
| Append-only rows (water logs, review history, workout history, awards) | Union: insert if the id is missing; never changed. |
| Delete vs edit | A delete beats an older edit. An edit newer than the delete resurrects the row and is pushed back. |
| Server | Ignores an incoming record that is older than the stored one, so an old device cannot overwrite newer data. |

Timestamps have one-second resolution; two edits in the same second tie.

## Failure handling

- A failed push or pull throws `SyncException` (`offline`, `unauthorized`,
  `server`, `invalid_response`, `disabled`); the error code is saved on the
  profile's sync settings and shown (as friendly text) in Settings.
- Retries are safe: re-sending is idempotent and the cursor advances only
  after a page is applied.
- Remote records with unknown tables, unknown columns, bad value types, a
  missing parent row, or that the schema rejects are skipped and counted, not
  applied; one bad row never aborts the sync.
- Signing out disables sync, forgets cursors and pending tombstones, and keeps
  all local data. Signing in as a different account therefore starts from a
  clean cursor.

## What is verified

`test/sync_test.dart` runs two simulated devices (separate databases, separate
clocks, different local profile ids) against an in-memory server that follows
the same rules as the SQL function: round trip, opt-in categories, retries
without duplicates, last-writer-wins, tie, delete propagation without echo,
edit-after-delete, delete-after-edit, union of append-only rows, 450-row
paging, disabled sync sending nothing, account separation and hostile
records. **It has not been run against a real Supabase project.**

## Known limits

- Sync is triggered manually ("Sync now"); there is no background or
  automatic sync yet.
- No conflict-review UI: the rules above are applied silently (by design they
  never discard a newer write).
- Conflicts are resolved per row, not per field.
