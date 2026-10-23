# Backend (optional): Supabase contracts and verification

Nothing in this folder is required to use Nuvora. If you enable cloud sync or
the AI assistant, the app talks only to your own Supabase project.

> **Status:** everything here was written and reviewed but **not deployed or
> tested against a live project** by the author. Use the checklist at the end
> before storing real data.

## Components

| Piece | File | Purpose |
| --- | --- | --- |
| Sync table, RLS, push function | `backend/supabase/migrations/0001_sync.sql` | storage and authorization for synced rows |
| AI quota table | `backend/supabase/migrations/0002_ai_usage.sql` | daily per-user AI counter |
| Database tests | `backend/supabase/tests/sync_rls.test.sql` | pgTAP isolation tests |
| `delete-account` | `backend/supabase/functions/delete-account/index.ts` | server-side account deletion |
| `ai` | `backend/supabase/functions/ai/index.ts` | AI gateway |

## Authentication

Email and password through Supabase Auth (GoTrue), called by the app over
HTTPS:

| Action | Request |
| --- | --- |
| Register | `POST /auth/v1/signup {email, password}`. With "Confirm email" on, no session is returned until the user opens the link in the verification email. |
| Login | `POST /auth/v1/token?grant_type=password {email, password}` |
| Refresh | `POST /auth/v1/token?grant_type=refresh_token {refresh_token}` |
| Password reset | `POST /auth/v1/recover {email}` (the provider emails a link) |
| Logout | `POST /auth/v1/logout` (best effort; local sign-out always succeeds) |

Passwords are forwarded once to the provider and never stored or logged by the
app. Tokens are stored in Android secure storage and never in the database,
preferences or backups. Failures map to fixed codes (`invalid_credentials`,
`email_not_verified`, `weak_password`, `email_taken`, `rate_limited`,
`offline`, `server`); server text is not shown.

## Sync data access

Authorization is enforced by **row-level security**, not by the app.

```
POST /rest/v1/rpc/push_sync_records
Authorization: Bearer <user JWT>   apikey: <anon key>
{ "records": [ { "table_name": "subjects", "row_id": "<uuid>",
                 "data": { ...columns... }, "deleted": false,
                 "updated_at": "2024-05-10T09:00:00.000Z" } ] }
-> 204
```

- At most 500 records per call; `data` at most 64 KiB; `table_name` must be in
  the allow-list; `deleted` rows must have no data.
- An existing row is replaced only if `incoming.updated_at >= stored.updated_at`.

```
GET /rest/v1/sync_records?select=table_name,row_id,data,deleted,updated_at,seq
                          &seq=gt.<cursor>&order=seq.asc&limit=200
-> 200 [ { "table_name": ..., "row_id": ..., "data": {...}|null,
           "deleted": false, "updated_at": "...", "seq": 123 } ]
```

Policies: `select`, `insert`, `update` and `delete` are each limited to
`user_id = auth.uid()`; the table is `FORCE ROW LEVEL SECURITY`; the `anon`
role has no privileges. The service-role key is never used by the app.

## Account deletion

```
POST /functions/v1/delete-account        Authorization: Bearer <user JWT>
-> 200 {"ok": true}   401 {"error":"unauthorized"}   500 {"error":"delete_failed"}
```

The function identifies the caller from their JWT (a user id in the body is
ignored) and deletes the auth user with the service-role key held server side.
`sync_records.user_id` and `ai_usage.user_id` reference `auth.users` with
`ON DELETE CASCADE`, so all cloud rows disappear. Data on the device is kept.

## AI gateway

```
POST /functions/v1/ai                    Authorization: Bearer <user JWT>
{ "kind": "coach|flashcards|summarize|questions|explain",
  "text": "<user notes, <= 8000 chars>",           // not used for coach
  "context": { "study": {"minutes_total": 210, ...} } }   // aggregates only
-> 200 { "text": "...", "cards": [ {"front": "...", "back": "..."} ] }
   401 unauthorized   413 too_large   429 rate_limited   5xx server / invalid_response
```

The function validates the JWT, bounds the body (24 KiB), allow-lists `kind`,
sanitizes `context` to plain aggregates, enforces a daily quota
(`AI_DAILY_LIMIT`, default 30) through `increment_ai_usage`, calls the provider
with a server-side key, requires structured JSON back and validates and
truncates it. Request and reply content is **not logged**. The system prompt
forbids acting as a doctor, therapist or religious authority, forbids writing
or changing Quran text, forbids inventing user statistics and unsafe advice.
The app validates the reply again and always labels it "AI-generated".

Secrets live only in the function environment: `AI_PROVIDER_API_KEY`,
`AI_MODEL`, `AI_DAILY_LIMIT` (plus the automatic `SUPABASE_URL` and
`SUPABASE_SERVICE_ROLE_KEY`).

## Verification checklist (do this before real use)

1. `supabase db push`, then `supabase test db`: all eight pgTAP tests pass.
2. Create two test users. As user A push a row; as user B confirm you cannot
   select, update or delete it, and cannot insert a row with A's `user_id`.
3. Confirm the `anon` key without a user JWT is rejected on `sync_records`.
4. Push a record with an older `updated_at` than stored: stored data unchanged.
5. Push a table name outside the allow-list: rejected.
6. Sign up with email confirmation on: no session until verified; reset email
   arrives; the reset flow works.
7. Call `delete-account` as a test user: auth user and all `sync_records` rows
   are gone. Call it without a token: 401.
8. Call `ai` without a token (401), with an oversized body (413), repeatedly
   past the limit (429). Confirm logs contain no request or reply text.
9. From the app, sync two devices and compare the results with
   `docs/SYNC.md`.
10. Confirm no service-role or provider key exists in the built APK
    (`test/cloud_test.dart` also scans the source for this).
