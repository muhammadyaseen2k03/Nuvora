# Rules and algorithms

These are the exact, tested rules the app follows. Each section names the test
file that pins the behaviour.

## Prayer times and tracking

**Calculation.** Times come from the `adhan_dart` library (a port of the
Adhan project) using the selected method and Asr method (standard/Shafi or
Hanafi). The high-latitude rule is `HighLatitudeRule.recommended`. Times are
calculated on the device for the chosen coordinates and converted to the
phone's time zone, so the phone's daylight-saving rules apply. They may differ
from a local mosque timetable and the app says so on screen.

Reference tests (`test/prayer_test.dart`): Raleigh, 2015-07-12, ISNA method,
Hanafi Asr matches the Adhan project's published times within one minute; the
standard Asr time is checked against an independent hand calculation from
solar geometry.

**Statuses.** A prayer can be recorded as `onTime`, `late` or `missed`. A prayer
with **no row** is "not recorded". It is never treated as missed.

**Streaks** (`lib/features/prayer/prayer_streaks.dart`):

- A day is *complete* when all five prayers are recorded as completed
  (`onTime` or `late`). With the strict option, only `onTime` counts.
- Any `missed` or unrecorded prayer makes the day incomplete.
- The *current streak* is the number of consecutive complete days ending today.
  If today is not complete yet, it ends yesterday instead, so a day in
  progress never resets it.
- The *longest streak* is the longest run of consecutive complete calendar
  days. Calendar-day arithmetic uses date fields, so daylight-saving changes
  cannot skip or repeat a day.

## Daily completion score

`lib/features/home/daily_score.dart`. Weighted average of per-goal progress
(each capped at 1):

| Goal | Progress |
| --- | --- |
| Prayers | prayers recorded completed today / 5 |
| Study | focus minutes today / daily study goal |
| Workout | 1 if a workout was completed today, else 0 |
| Water | ml logged today / daily water goal |

Default weights are equal. A goal with weight 0 is excluded. The score
describes activity only; the Home screen says it is not a measure of worth.
(The weights are supported by the function but there is no UI to change them
yet.)

## Spaced repetition

`lib/features/study/srs.dart`, an SM-2 variant. Cards keep an ease factor
(start 2.5, range 1.3 to 3.0), a repetition count and an interval in days.

| Rating | Repetitions | Next interval | Ease |
| --- | --- | --- | --- |
| Again | reset to 0 | 1 day | -0.20 |
| Hard | +1 | max(1, round(previous x 1.2)) | -0.15 |
| Good | +1 | 1st review 1 day, 2nd 3 days, then round(previous x ease) | unchanged |
| Easy | +1 | 1st review 3 days, then round(previous x ease x 1.3) | +0.15 |

The due date is the review's calendar day plus the interval, so a card is due
from the start of that local day. Every review is stored (rating, interval and
ease after) in `flashcard_reviews`, and the card update and the history row are
written in one transaction.

## Focus timer

`lib/features/study/focus_timer.dart`. Remaining time is computed from stored
timestamps (`started_at`, `paused_at`, accumulated paused milliseconds), never
from a running in-memory countdown. After the app is closed and reopened, the
same stored values give the same answer. A session that ran out while the app
was closed is finalized with its true end time (start + planned + paused
time), so the recorded duration is the planned length, not "when the app
noticed".

## Daily planner

`lib/features/planner/planner.dart` and `plan_generator.dart`. Offline and
deterministic.

1. Free time = the availability window (06:00-22:00) minus every fixed block,
   each widened by a 10-minute gap.
2. Fixed blocks are the five calculated prayer times (20 minutes each, only
   when a location is set), plus every activity the user pinned, completed,
   skipped or moved. These are never moved or removed.
3. Tasks, by priority: exams within 14 days (90 minutes when 3 days or fewer
   away, otherwise 60; at most two), due flashcards (10-30 minutes), up to two
   unfinished topics (45 minutes), and a workout of the preferred length not
   before 16:00.
4. Tasks are placed into the earliest slot that fits, after "now" when planning
   today. A task that cannot fit is reported, never silently dropped. A task
   may be shortened to its minimum length before being reported.
5. Regeneration replaces only unpinned, still-planned suggestions.

## Achievements, XP, weekly report

`lib/features/insights/`. A badge is awarded only when stored data meets its
criterion, and an award is never removed or duplicated.

| Badge | Criterion |
| --- | --- |
| Seven-day prayer tracking streak | current prayer streak >= 7 |
| Ten focus sessions | 10 completed (not cancelled) focus sessions |
| Twenty study hours this month | >= 1200 focus minutes this calendar month |
| Ten workouts | >= 10 finished workouts |
| Hydration week | water goal met on 7 consecutive days (ending today or yesterday) |

XP: 10 per focus session, 20 per workout, 5 per prayer recorded as completed;
a level every 200 XP. It is only a motivational counter.

The weekly report (last 7 days) shows the most consistent day (highest daily
score), study minutes by subject, workouts, prayers recorded as completed out
of prayers recorded, days the water goal was met, and one rule-based
suggestion for the weakest category.

## Calendar day status

`lib/features/habits/day_status.dart`: *unrecorded* (nothing recorded),
*missed* (only explicitly missed prayers recorded), *partial* (some goal
progress), *complete* (every goal met). The calendar uses the same four
equal-weight goals as the Home score, so "complete" is a high bar. Status is
shown by icon as well as colour.

## Reminders

`lib/features/notifications/notification_planner.dart`.

- Each category (prayer, study, workout, water, reflection, flashcards, weekly
  summary) is independent and off by default.
- Only the next three days are scheduled (Android limits pending alarms); the
  weekly summary looks seven days ahead. The app re-plans on launch, resume,
  locale change and when prayer settings change.
- Stable ids per reminder and day mean a re-plan replaces rather than
  duplicates.
- Quiet hours (may wrap midnight) silence everything **except** prayer
  reminders, which the user chose individually.
- Water: at most 8 per day, at least 60 minutes apart, 09:00-21:00.
- Flashcard reminders only for today and only when cards are due.
- Text is generic by default ("You have a reminder.") so nothing personal
  appears on a locked screen; the user can opt in to details.
- Rescheduling never shows a permission prompt. The prompt appears only when
  the user presses "Allow notifications" after reading why.
