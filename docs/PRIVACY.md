# Privacy and security

## Principles

Collect the minimum, keep it on the device by default, explain before
sending anything, and let the user export and delete their data.

## What stays on the device (default)

Everything. Profiles, prayer records, study data, flashcards, workouts, water,
fasting, plans, journal, achievements, preferences, reminders and AI history
live in a local SQLite database. Multiple local profiles are isolated by
profile id with foreign keys and cascading deletes; every repository query is
scoped to a profile id, and tests check that one profile cannot read or change
another's rows.

## What can leave the device, and only if you choose

| Feature | What is sent | When |
| --- | --- | --- |
| Cloud sync | the categories you tick (study, fitness, prayer, journal) plus preferences, plans and achievements, to your own Supabase account over HTTPS | only after you sign in, turn sync on, and press Sync now |
| AI assistant | for the coach: aggregated numbers from the categories you allow; for study tools: only the text you typed for that request. Never your journal, name or any identifier | only after you turn the assistant on, and only when you press a button |
| Cloud account | email and password, sent once to the auth provider | when you sign in or register |

Journal text is excluded from the AI feature entirely. Prayer data is private
by default: sync and AI sharing for it are separate opt-in switches.

## Local-only recovery question

The data model can store a recovery question with a PBKDF2-HMAC-SHA256
verifier (100,000 iterations, random salt) instead of the answer. It only helps
on the device that holds the profile, offers no server-level identity check,
and cannot protect against someone who has the device storage and can guess a
weak answer. There is currently no screen that sets it; the repository and
tests exist.

## Credentials and secrets

- Passwords are never stored or logged by the app. For cloud accounts they are
  handled by the auth provider.
- Cloud session tokens are kept in Android secure storage (Keystore-backed),
  never in the database, preferences or backups.
- The app contains no service-role key and no AI provider key; a test scans
  the source for them. The anon key (public by design) is supplied at build
  time.
- Backups exclude the recovery question, its verifier and salt, and the cloud
  id.
- Logs: the app does not log passwords, tokens, recovery answers or journal
  text. The AI function does not log request or reply content.

## Encryption, stated plainly

| Data | In transit | At rest |
| --- | --- | --- |
| Cloud sync and auth traffic | HTTPS (TLS) | encrypted by the Supabase platform's storage (provider feature, not verified here) |
| AI requests | HTTPS to your function, then HTTPS to the provider | per provider policy |
| Local database | n/a | **not separately encrypted by Nuvora**; relies on Android's app sandbox and device encryption |
| Backup files | n/a | **not encrypted**; the user is told to keep them private |
| Session tokens | n/a | Android Keystore-backed secure storage |

Nuvora does **not** implement end-to-end encryption and does not claim to.
Adding an encrypted local database (for example SQLCipher) and encrypted
backups is future work.

## Notifications

Text is generic by default ("You have a reminder.") so nothing personal shows
on a lock screen. Details are an explicit opt-in. Notification permission is
requested only after an explanation and an explicit button press, and a denial
is respected.

## Data export and deletion

- **Export:** Settings > Backup > Export backup (a JSON file for the active
  profile).
- **Delete local data:** Settings > Profiles > delete (removes the profile and
  all of its rows from the device, irreversibly, after confirmation).
- **Delete cloud data:** Settings > Cloud sync > Delete cloud account.
- **Clear AI history:** AI assistant > Clear history.
- Signing out of the cloud keeps local data and stops syncing.

## Religious and health content

Prayer times are calculated, labelled as such, and may differ from a local
timetable. The app never generates or alters Quran text, and the AI is
instructed not to. The AI is not presented as a religious authority, doctor or
therapist, and answers carry a disclaimer. Fasting and hydration screens state
that goals are personal, not medical advice.
