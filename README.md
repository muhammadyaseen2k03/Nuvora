# Nuvora

> Strengthen Your Body, Elevate Your Soul, Expand Your Mind.

Nuvora is an offline-first Flutter app (Android first) that brings three parts
of daily life into one calm place:

- **Body**: workouts, water, fasting timer.
- **Soul**: calculated prayer times, prayer tracking, streaks.
- **Mind**: focus timer, subjects and syllabus, exams, spaced-repetition flashcards.

Around them sit a **daily planner**, a **habit calendar**, a private
**journal**, **progress** (milestones, XP, weekly report), local **reminders**,
**backup and restore**, and two clearly optional layers: **cloud sync** and an
**AI assistant**.

> See "Status in one paragraph" below for what is verified and what is not.

## Status in one paragraph

All core tracking works with no internet and is covered by automated tests
(unit, repository and widget tests on an in-memory database). Cloud sync,
cloud accounts and the AI assistant are implemented and tested against
in-memory or mocked servers, **but the backend has not been deployed or
tested against a live Supabase project, and no AI provider has been called**.
Notifications are planned and scheduled by tested code, but delivery has not
been observed on a physical phone. Several features from the original
specification are not built (Qibla, Quran tracker, dhikr counter, body
measurements, workout set logging, app lock, and more; see the report).

## Requirements

| Item | Version used |
| --- | --- |
| Windows 10 or 11 | tested on Windows 10 Pro |
| Flutter | 3.47.7 (stable), Dart 3.13.5 |
| Android Studio | with Android SDK and the bundled JDK 17+ |
| Git | any recent version |

Costs: Flutter, Android Studio and the app itself are free. Optional services:
a Supabase project (free tier is enough to try it), an AI provider account
(pay per use, only if you enable the AI assistant), and a one-time Google Play
developer fee (US$25) only if you publish to the Play Store.

## Windows setup

1. **Install Git** from <https://git-scm.com/download/win>.
2. **Install Flutter.** Either follow <https://docs.flutter.dev/get-started/install/windows/mobile>
   or, in PowerShell:
   ```powershell
   git clone https://github.com/flutter/flutter.git -b stable C:\src\flutter
   ```
   Add `C:\src\flutter\bin` to your `PATH`, then open a new terminal and run
   `flutter --version`.
3. **Install Android Studio** from <https://developer.android.com/studio>, open
   it once, and install the Android SDK (SDK Platform and Command-line Tools)
   from *Settings > Languages & Frameworks > Android SDK*.
4. **Point Flutter at them** (adjust paths if yours differ):
   ```powershell
   flutter config --android-sdk "$env:LOCALAPPDATA\Android\Sdk"
   flutter config --jdk-dir "C:\Program Files\Android\Android Studio\jbr"
   flutter doctor --android-licenses
   flutter doctor
   ```
   Fix anything `flutter doctor` flags for Android.
5. **Get the project and its dependencies:**
   ```powershell
   cd path\to\nuvora
   flutter pub get
   dart run build_runner build      # generates the Drift database code
   flutter gen-l10n                 # generates the localization classes
   ```
   The generated files (`lib/data/database.g.dart`, `lib/l10n/gen/`) are
   included in the project, so this step is only needed after changing a table or a string.

## Run on an emulator or a phone

- **Emulator:** in Android Studio open *Device Manager*, create a device with a
  recent Android image, start it, then `flutter run`.
- **Physical phone:** enable *Developer options* and *USB debugging*, connect
  by USB, accept the prompt on the phone, check `flutter devices`, then
  `flutter run -d <device id>`.
- **Install a built APK:** `adb install -r build\app\outputs\flutter-apk\app-debug.apk`.

The app starts with an onboarding flow that creates a local profile. No account
is needed.

## Quality checks

```powershell
flutter analyze        # static analysis; expected: No issues found
flutter test           # unit, repository and widget tests
```

Tests use an in-memory SQLite database, so they run without a device. A few
test files simulate several devices against an in-memory sync server and use
mocked HTTP.

To regenerate the screenshots used in reviews (renders real widgets, not a
device):

```powershell
flutter test tool/screenshots_test.dart --update-goldens   # writes tool/screenshots/
```

## Build an APK

```powershell
flutter build apk --debug                       # build\app\outputs\flutter-apk\app-debug.apk
flutter build apk --release                     # app-release.apk
flutter build appbundle --release               # for the Play Store
```

**Release signing.** `flutter build apk --release` currently signs with the
*debug* key (see `android/app/build.gradle.kts`), which is fine for testing
but **not for distribution**. Before publishing, create a keystore and
configure `signingConfigs.release` following
<https://docs.flutter.dev/deployment/android#sign-the-app>. Keep the keystore
and `key.properties` out of version control.

To build with cloud features enabled, pass your configuration (see
[.env.example](.env.example)):

```powershell
flutter build apk --release --dart-define-from-file=.env
```

## Optional: cloud sync and the AI assistant

Both are **off** unless you configure a Supabase project and supply its URL
and anon key at build time. Without them the app hides cloud sign-in and the
AI features say they are not set up, and everything else works.

1. Create a project at <https://supabase.com>.
2. Authentication > Providers: enable *Email*. Keep *Confirm email* on so
   accounts must be verified. Set the site URL / redirect for password reset.
3. Install the Supabase CLI, `supabase login`, `supabase link --project-ref <ref>`.
4. Apply the database schema and policies:
   ```powershell
   supabase db push        # applies backend/supabase/migrations/*.sql
   ```
5. Deploy the server functions and set their secrets (server side only):
   ```powershell
   supabase functions deploy delete-account
   supabase functions deploy ai
   supabase secrets set AI_PROVIDER_API_KEY=... AI_MODEL=... AI_DAILY_LIMIT=30
   ```
6. Run the database tests, then verify isolation yourself (checklist in
   [docs/BACKEND.md](docs/BACKEND.md)):
   ```powershell
   supabase test db
   ```
7. Build the app with `--dart-define-from-file=.env`.

**Important:** the SQL, the RLS policies and both functions were written and
reviewed but **not run against a live project by the author**. Treat
[docs/BACKEND.md](docs/BACKEND.md) as your acceptance checklist before trusting
them with real data.

## Permissions the app asks for

| Permission | When | Why |
| --- | --- | --- |
| Notifications (Android 13+) | only when you press "Allow notifications" on the Reminders screen, after an explanation | prayer, study, workout, water, reflection and weekly-summary reminders |
| Boot completed | declared, no prompt | restores scheduled reminders after a restart |
| Internet | implicit | only used if you enable cloud sync or the AI assistant |

Location is **not** requested: choose a city or enter coordinates for prayer
times. Exact-alarm permission is not requested; reminders may arrive a few
minutes late on some phones.

## Documentation

- [docs/RULES.md](docs/RULES.md): the exact rules for streaks, daily score, spaced repetition, planner, notifications and achievements.
- [docs/SYNC.md](docs/SYNC.md): offline-first sync design and conflict rules.
- [docs/BACKEND.md](docs/BACKEND.md): API contracts, setup and the verification checklist.
- [docs/PRIVACY.md](docs/PRIVACY.md): what stays local, what can be uploaded, what is and is not encrypted.

## Project layout

```
lib/
  app/            entry, router, providers (Riverpod), app shell
  core/           theme and design tokens, shared widgets
  data/           Drift database, migrations, table descriptions
  l10n/           English and Urdu strings (ARB)
  features/
    auth/         local profiles, onboarding, recovery verifier, cloud auth client
    home/         dashboard, daily score
    prayer/       times, tracking, streaks
    study/        focus timer, subjects, exams, flashcards (SRS)
    fitness/      workout library and player, water, fasting
    planner/      rule-based daily planner
    habits/       calendar, journal
    insights/     achievements, weekly report, history queries
    notifications/ reminder planner, service, Android scheduler, settings UI
    backup/       versioned export and restore
    sync/         sync engine, remote clients, cloud account service
    ai/           consent-gated AI client, service and screen
    settings/     preferences, backup, cloud and privacy sections
backend/supabase/ SQL migrations, RLS tests, edge functions
docs/             rules, sync, backend and privacy notes
test/             automated tests
tool/             screenshot renderer
```

## Honest limitations

- Inter is not bundled yet; the UI uses the platform sans-serif (Roboto on Android).
- Timestamps in the database are stored with one-second resolution.
- The planner's day window is fixed at 06:00-22:00 and is not yet user-editable.
- On-device data is not separately encrypted; it relies on Android's app sandbox
  and device encryption. Cloud traffic uses HTTPS and is **not** end-to-end
  encrypted.
- Prayer times are calculated and may differ from a local mosque timetable.
  Times are shown in the phone's time zone.
