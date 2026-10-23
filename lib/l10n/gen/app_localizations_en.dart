// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Nuvora';

  @override
  String get tagline =>
      'Strengthen Your Body, Elevate Your Soul, Expand Your Mind.';

  @override
  String get navHome => 'Home';

  @override
  String get navPrayer => 'Prayer';

  @override
  String get navStudy => 'Study';

  @override
  String get navFitness => 'Fitness';

  @override
  String get body => 'Body';

  @override
  String get soul => 'Soul';

  @override
  String get mind => 'Mind';

  @override
  String greetingMorning(String name) {
    return 'Good morning, $name';
  }

  @override
  String greetingAfternoon(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String greetingEvening(String name) {
    return 'Good evening, $name';
  }

  @override
  String get homeBuilding => 'You\'re building consistency, one day at a time.';

  @override
  String get sectionComingTitle => 'Coming in the next phase';

  @override
  String get sectionComingBody =>
      'This section is not built yet. Nothing here is saved or simulated.';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get profiles => 'Profiles';

  @override
  String get activeProfile => 'Active';

  @override
  String get switchProfile => 'Switch';

  @override
  String get addProfile => 'Add profile';

  @override
  String get deleteProfile => 'Delete profile';

  @override
  String get deleteProfileTitle => 'Delete this profile?';

  @override
  String get deleteProfileBody =>
      'This permanently removes the profile and all of its data from this device. It cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get finish => 'Get started';

  @override
  String get welcomeTitle => 'Welcome to Nuvora';

  @override
  String get nameTitle => 'What should we call you?';

  @override
  String get nameHint => 'Preferred name';

  @override
  String get nameRequired => 'Please enter a name';

  @override
  String get modeTitle => 'Where should your data live?';

  @override
  String get modeLocal => 'On this device only';

  @override
  String get modeLocalDesc => 'Works fully offline. Nothing is uploaded.';

  @override
  String get modeCloud => 'Cloud sync';

  @override
  String get modeCloudDesc => 'Not available yet. Local mode works without it.';

  @override
  String get themeTitle => 'Choose your look';

  @override
  String get languageTitle => 'Choose your language';

  @override
  String get studyTitle => 'Daily study goal';

  @override
  String studyMinutes(int minutes) {
    return '$minutes min per day';
  }

  @override
  String get fitnessTitle => 'Fitness';

  @override
  String get fitnessBeginner => 'Beginner';

  @override
  String get fitnessIntermediate => 'Intermediate';

  @override
  String get fitnessAdvanced => 'Advanced';

  @override
  String workoutMinutes(int minutes) {
    return 'Workout length: $minutes min';
  }

  @override
  String get optionalLater => 'You can change all of this later in Settings.';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyLocalNote =>
      'All data is stored locally on this device. Cloud sync and AI features are off and not yet available.';

  @override
  String get recoveryNote =>
      'Local profiles have no server-side identity. A recovery question can only help on this device and cannot verify who you are.';

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String prayerNext(String name) {
    return 'Next: $name';
  }

  @override
  String get prayerNextFajrTomorrow => 'Next: Fajr (tomorrow)';

  @override
  String prayerIn(String time) {
    return 'in $time';
  }

  @override
  String get prayerNeedLocationTitle => 'Choose your location';

  @override
  String get prayerNeedLocationBody =>
      'Prayer times are calculated on this device from your location. You can pick a city or enter coordinates; no location permission is needed.';

  @override
  String get prayerSetLocation => 'Set location';

  @override
  String get prayerSettings => 'Prayer settings';

  @override
  String get prayerMethod => 'Calculation method';

  @override
  String get prayerAsrMethod => 'Asr calculation';

  @override
  String get prayerAsrStandard => 'Standard (earlier Asr)';

  @override
  String get prayerAsrHanafi => 'Hanafi (later Asr)';

  @override
  String get prayerCity => 'City';

  @override
  String get prayerCustomLocation => 'Custom coordinates';

  @override
  String get prayerLatitude => 'Latitude';

  @override
  String get prayerLongitude => 'Longitude';

  @override
  String get prayerInvalidNumber => 'Enter a valid number';

  @override
  String get prayerLatRange => 'Latitude must be between -90 and 90';

  @override
  String get prayerLonRange => 'Longitude must be between -180 and 180';

  @override
  String get save => 'Save';

  @override
  String get prayerDisclaimer =>
      'Times are calculated and may differ from your local mosque timetable. Times are shown in this device\'s time zone.';

  @override
  String get prayerStatusOnTime => 'On time';

  @override
  String get prayerStatusLate => 'Late';

  @override
  String get prayerStatusMissed => 'Missed';

  @override
  String get prayerStatusNone => 'Not recorded';

  @override
  String get prayerStatusClear => 'Clear record';

  @override
  String get prayerToday => 'Today';

  @override
  String prayerStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count day streak',
      one: '1 day streak',
      zero: 'No current streak',
    );
    return '$_temp0';
  }

  @override
  String prayerLongest(int count) {
    return 'Longest: $count';
  }

  @override
  String get prayerStreakNote =>
      'A day counts when all five prayers are recorded as completed. Days with prayers not recorded are not treated as missed.';

  @override
  String get prayerWeek => 'Last 7 days';

  @override
  String prayerWeekSummary(int completed, int missed, int unrecorded) {
    return '$completed completed · $missed missed · $unrecorded not recorded';
  }

  @override
  String prayerRecordFor(String name) {
    return 'Record $name';
  }

  @override
  String get studyTabFocus => 'Focus';

  @override
  String get studyTabSubjects => 'Subjects';

  @override
  String get studyTabCards => 'Cards';

  @override
  String get focusKindFocus => 'Focus';

  @override
  String get focusKindShort => 'Short break';

  @override
  String get focusKindLong => 'Long break';

  @override
  String focusMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get focusSubjectOptional => 'Subject (optional)';

  @override
  String get focusNoSubject => 'No subject';

  @override
  String get focusStart => 'Start';

  @override
  String get focusPause => 'Pause';

  @override
  String get focusResume => 'Resume';

  @override
  String get focusCancel => 'Cancel session';

  @override
  String get focusPresets => 'Presets';

  @override
  String focusTodaySummary(int count, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count focus sessions',
      one: '1 focus session',
      zero: 'no focus sessions yet',
    );
    return 'Today: $_temp0, $minutes min';
  }

  @override
  String get focusDone => 'Session complete. Nicely done.';

  @override
  String get focusRecovered =>
      'Your session kept running while the app was closed.';

  @override
  String get subjectsEmpty =>
      'No subjects yet. Add one to organize your syllabus.';

  @override
  String get subjectAdd => 'Add subject';

  @override
  String get subjectName => 'Subject name';

  @override
  String subjectProgress(int completed, int total) {
    return '$completed of $total topics completed';
  }

  @override
  String get subjectDeleteBody =>
      'This also deletes its topics. Flashcards keep existing but lose the subject link.';

  @override
  String get topicAdd => 'Add topic';

  @override
  String get topicTitle => 'Topic title';

  @override
  String get topicPriority => 'Priority';

  @override
  String get topicPriorityHigh => 'High';

  @override
  String get topicPriorityMedium => 'Medium';

  @override
  String get topicPriorityLow => 'Low';

  @override
  String get topicEstimate => 'Estimated minutes (optional)';

  @override
  String get topicStatusNotStarted => 'Not started';

  @override
  String get topicStatusInProgress => 'In progress';

  @override
  String get topicStatusCompleted => 'Completed';

  @override
  String get topicsEmpty =>
      'No topics yet. Break this subject into topics you can complete.';

  @override
  String get examsTitle => 'Upcoming exams';

  @override
  String get examsEmpty => 'No upcoming exams.';

  @override
  String get examAdd => 'Add exam';

  @override
  String get examName => 'Exam name';

  @override
  String get examDate => 'Exam date';

  @override
  String examDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'In $days days',
      one: 'Tomorrow',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String cardsDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards due',
      one: '1 card due',
      zero: 'No cards due',
    );
    return '$_temp0';
  }

  @override
  String get cardsReview => 'Review cards';

  @override
  String get cardAdd => 'Add card';

  @override
  String get cardFront => 'Front (question)';

  @override
  String get cardBack => 'Back (answer)';

  @override
  String get cardRequired => 'This field is required';

  @override
  String get cardsEmpty => 'No flashcards yet. Add your first card.';

  @override
  String get cardArchive => 'Archive';

  @override
  String get cardDelete => 'Delete card';

  @override
  String get cardShowAnswer => 'Show answer';

  @override
  String get ratingAgain => 'Again';

  @override
  String get ratingHard => 'Hard';

  @override
  String get ratingGood => 'Good';

  @override
  String get ratingEasy => 'Easy';

  @override
  String get reviewAllDone => 'All caught up. No more cards are due.';

  @override
  String reviewProgress(int current, int total) {
    return 'Card $current of $total';
  }

  @override
  String cardsStats(int reviews, int retention) {
    return 'Last 30 days: $reviews reviews, $retention% recalled';
  }

  @override
  String get cardsStatsNone => 'No reviews yet.';

  @override
  String cardNextReview(String date) {
    return 'Next review: $date';
  }

  @override
  String get fitnessTabWorkouts => 'Workouts';

  @override
  String get fitnessTabWater => 'Water';

  @override
  String get fitnessTabFasting => 'Fasting';

  @override
  String get categoryFullBody => 'Full body';

  @override
  String get categoryUpperBody => 'Upper body';

  @override
  String get categoryLowerBody => 'Lower body';

  @override
  String get categoryCore => 'Core';

  @override
  String get categoryMobility => 'Mobility';

  @override
  String get categoryQuick => 'Quick';

  @override
  String get workoutStart => 'Start workout';

  @override
  String workoutReps(int count) {
    return '$count reps';
  }

  @override
  String workoutSeconds(int count) {
    return '$count sec';
  }

  @override
  String get workoutRest => 'Rest';

  @override
  String workoutUpNext(String name) {
    return 'Up next: $name';
  }

  @override
  String workoutEasier(String text) {
    return 'Easier option: $text';
  }

  @override
  String get workoutDone => 'Done';

  @override
  String get workoutSkip => 'Skip';

  @override
  String get workoutPrevious => 'Previous';

  @override
  String get workoutEnd => 'End workout';

  @override
  String get workoutComplete => 'Workout complete';

  @override
  String workoutSummary(int completed, int total, int minutes) {
    return '$completed of $total exercises, $minutes min';
  }

  @override
  String get workoutSafety =>
      'Move at your own pace and stop if anything hurts. If you have a health condition or injury, check with a qualified professional first.';

  @override
  String get workoutHistory => 'Recent workouts';

  @override
  String get workoutHistoryEmpty => 'No workouts completed yet.';

  @override
  String waterToday(int ml, int goal) {
    return '$ml of $goal ml';
  }

  @override
  String get waterCustom => 'Custom amount';

  @override
  String get waterAmount => 'Amount (ml)';

  @override
  String get waterUndo => 'Undo last';

  @override
  String get waterGoal => 'Daily goal (ml)';

  @override
  String get waterGoalNote =>
      'Your goal is personal and adjustable. It is not medical advice.';

  @override
  String get waterHistory => 'Last 7 days';

  @override
  String waterAddMl(int ml) {
    return 'Add $ml ml';
  }

  @override
  String get fastStart => 'Start fast';

  @override
  String get fastEnd => 'End fast';

  @override
  String get fastTarget => 'Planned length';

  @override
  String get fastNoTarget => 'No target';

  @override
  String fastHours(int hours) {
    return '$hours h';
  }

  @override
  String get fastElapsed => 'Elapsed';

  @override
  String fastRemaining(String time) {
    return '$time remaining';
  }

  @override
  String get fastGoalReached => 'Planned length reached';

  @override
  String get fastHistory => 'Past fasts';

  @override
  String get fastHistoryEmpty => 'No fasts recorded yet.';

  @override
  String get fastSafety =>
      'Fasting is not suitable for everyone. Stop if you feel unwell, and speak with a health professional if you have a medical condition, are pregnant, or take medication.';

  @override
  String get homeScoreTitle => 'Today\'s progress';

  @override
  String get homeScoreNote =>
      'Based on prayers recorded, study minutes, workout and water. It describes today\'s activity only, not your worth.';

  @override
  String get tilePrayers => 'Prayers';

  @override
  String get tileStudy => 'Study';

  @override
  String get tileWorkout => 'Workout';

  @override
  String get tileWater => 'Water';

  @override
  String tilePrayersValue(int done) {
    return '$done of 5';
  }

  @override
  String tileStudyValue(int minutes, int goal) {
    return '$minutes of $goal min';
  }

  @override
  String get tileWorkoutDone => 'Done';

  @override
  String get tileWorkoutNotYet => 'Not yet';

  @override
  String tileWaterValue(int ml, int goal) {
    return '$ml of $goal ml';
  }

  @override
  String homeNextPrayerAt(String name, String time) {
    return '$name at $time';
  }

  @override
  String get homeNoLocation => 'Set your prayer location to see times';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get quickPrayer => 'Log prayer';

  @override
  String get quickFocus => 'Focus';

  @override
  String get quickWorkout => 'Workout';

  @override
  String get quickWater => '+250 ml';

  @override
  String get homeOffline =>
      'Everything works offline. Your data stays on this device.';

  @override
  String get moreTitle => 'Plan and progress';

  @override
  String get plannerTitle => 'Daily plan';

  @override
  String get calendarTitle => 'Habit calendar';

  @override
  String get journalTitle => 'Reflection';

  @override
  String get progressTitle => 'Progress';

  @override
  String get plannerGenerate => 'Suggest a plan';

  @override
  String get plannerRegenerate => 'Update suggestions';

  @override
  String get plannerNote =>
      'Suggestions are made on this device from your prayer times, exams, topics, due cards and workout length. Items you pin, complete or skip are kept when you update.';

  @override
  String get plannerEmpty => 'No plan yet. Suggest one based on your day.';

  @override
  String get plannerNothing =>
      'Nothing to schedule right now. Add exams, topics or cards, or set a prayer location.';

  @override
  String get plannerAddOwn => 'Add your own';

  @override
  String get plannerActivityTitle => 'Activity name';

  @override
  String get plannerStartTime => 'Start time';

  @override
  String get plannerEndTime => 'End time';

  @override
  String get plannerEndAfterStart => 'End must be after start';

  @override
  String get plannerPin => 'Keep fixed';

  @override
  String get plannerUnpin => 'Allow changes';

  @override
  String get plannerDone => 'Mark done';

  @override
  String get plannerSkip => 'Skip';

  @override
  String get plannerBegin => 'Begin';

  @override
  String get plannerReopen => 'Back to planned';

  @override
  String get plannerRemove => 'Remove';

  @override
  String plannerNotScheduled(String titles) {
    return 'Could not fit: $titles';
  }

  @override
  String get reasonExamSoon => 'Suggested because an exam is coming up.';

  @override
  String get reasonCardsDue => 'Suggested because flashcards are due.';

  @override
  String get reasonTopicPending =>
      'Suggested because this topic is not finished.';

  @override
  String get reasonWorkoutGoal => 'Suggested to fit your workout length.';

  @override
  String get statusDone => 'Done';

  @override
  String get statusSkipped => 'Skipped';

  @override
  String get calendarComplete => 'All goals met';

  @override
  String get calendarPartial => 'Partly done';

  @override
  String get calendarMissed => 'Missed';

  @override
  String get calendarUnrecorded => 'Nothing recorded';

  @override
  String get calendarLegend =>
      'Complete = every goal met. Partly = something done. Missed = only missed prayers recorded. Empty = nothing recorded, which is not the same as missed.';

  @override
  String dayDetailPrayers(int done) {
    return 'Prayers completed: $done of 5';
  }

  @override
  String dayDetailStudy(int minutes) {
    return 'Study: $minutes min';
  }

  @override
  String dayDetailWorkouts(int count) {
    return 'Workouts: $count';
  }

  @override
  String dayDetailWater(int ml) {
    return 'Water: $ml ml';
  }

  @override
  String get journalToday => 'Today\'s reflection';

  @override
  String get journalPromptWell => 'What went well today?';

  @override
  String get journalPromptLearned => 'What did I learn?';

  @override
  String get journalPromptImprove => 'What would I improve tomorrow?';

  @override
  String get journalPromptGrateful => 'What am I grateful for?';

  @override
  String get journalPrivate =>
      'Private. Stored only on this device and never shared with cloud or AI services.';

  @override
  String get journalSearch => 'Search entries';

  @override
  String get journalNoEntries => 'No entries yet.';

  @override
  String get journalSaved => 'Saved';

  @override
  String get journalDeleteTitle => 'Delete this entry?';

  @override
  String get journalDeleteBody =>
      'This permanently removes the entry from this device.';

  @override
  String get journalEdit => 'Edit';

  @override
  String progressLevel(int level) {
    return 'Level $level';
  }

  @override
  String progressXp(int xp) {
    return '$xp XP';
  }

  @override
  String get progressXpNote =>
      'XP: 10 per focus session, 20 per workout, 5 per prayer recorded as completed. Levels come every 200 XP. It is only a motivational counter.';

  @override
  String get badges => 'Milestones';

  @override
  String get badgeEarned => 'Earned';

  @override
  String get badgePrayerStreak7 => 'Seven-day prayer tracking streak';

  @override
  String get badgeFocus10 => 'Ten focus sessions';

  @override
  String get badgeStudy20h => 'Twenty study hours this month';

  @override
  String get badgeWorkouts10 => 'Ten workouts';

  @override
  String get badgeHydrationWeek => 'A week of meeting your water goal';

  @override
  String get weeklyReport => 'Last 7 days';

  @override
  String reportBestDay(String day) {
    return 'Most consistent day: $day';
  }

  @override
  String get reportNoBestDay => 'No activity recorded yet this week.';

  @override
  String reportStudy(int minutes) {
    return 'Study: $minutes min';
  }

  @override
  String reportWorkouts(int count) {
    return 'Workouts: $count';
  }

  @override
  String reportPrayers(int done, int recorded) {
    return 'Prayers recorded as completed: $done of $recorded recorded';
  }

  @override
  String reportWater(int days) {
    return 'Water goal met on $days of 7 days';
  }

  @override
  String reportSuggestion(String text) {
    return 'Next week: $text';
  }

  @override
  String get suggestWater =>
      'try a regular glass of water with each prayer or study break.';

  @override
  String get suggestStudy =>
      'schedule one short focus session at the same time each day.';

  @override
  String get suggestWorkout =>
      'pick one short workout from the library for a fixed day.';

  @override
  String get suggestPrayerTracking =>
      'tap your prayers as you complete them so your history is complete.';

  @override
  String get suggestKeepGoing =>
      'keep the rhythm you have. Small steady steps count.';

  @override
  String get cloudTitle => 'Cloud sync (optional)';

  @override
  String get cloudNotConfigured =>
      'Cloud sync is not set up in this build. Everything works on this device without it.';

  @override
  String get cloudIntro =>
      'Sync copies the data you choose to your own account so you can use Nuvora on more than one device. It is off unless you turn it on.';

  @override
  String get cloudEmail => 'Email';

  @override
  String get cloudPassword => 'Password';

  @override
  String get cloudEmailInvalid => 'Enter a valid email address';

  @override
  String get cloudPasswordShort => 'Use at least 8 characters';

  @override
  String get cloudSignIn => 'Sign in';

  @override
  String get cloudCreate => 'Create account';

  @override
  String get cloudForgot => 'Forgot password?';

  @override
  String get cloudResetSent =>
      'If an account exists for that email, a reset link has been sent.';

  @override
  String get cloudVerify =>
      'Check your email to verify your account, then sign in.';

  @override
  String cloudSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get cloudSyncEnable => 'Sync this profile';

  @override
  String get cloudCatPrayer => 'Prayer tracking (private by default)';

  @override
  String get cloudCatStudy => 'Study data';

  @override
  String get cloudCatFitness => 'Fitness data';

  @override
  String get cloudCatJournal => 'Journal entries (private)';

  @override
  String get cloudCatNote =>
      'When sync is on, preferences, plans and achievements are always included. Never synced: your name, recovery question, notification settings and consent choices. Data is sent over HTTPS to your account; it is not end-to-end encrypted.';

  @override
  String get cloudSyncNow => 'Sync now';

  @override
  String get cloudSyncing => 'Syncing...';

  @override
  String cloudLastSync(String time) {
    return 'Last sync: $time';
  }

  @override
  String get cloudNeverSynced => 'Not synced yet';

  @override
  String cloudSyncFailed(String reason) {
    return 'Last attempt failed: $reason';
  }

  @override
  String get cloudSyncDone => 'Sync finished';

  @override
  String cloudPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count changes waiting to sync',
      one: '1 change waiting to sync',
    );
    return '$_temp0';
  }

  @override
  String get errOffline => 'No connection. Your data is safe on this device.';

  @override
  String get errUnauthorized => 'Please sign in again.';

  @override
  String get errServer => 'The server had a problem. Try again later.';

  @override
  String get errInvalidCredentials => 'The email or password is incorrect.';

  @override
  String get errEmailNotVerified => 'Please verify your email first.';

  @override
  String get errWeakPassword => 'That password is too weak.';

  @override
  String get errEmailTaken => 'An account with that email already exists.';

  @override
  String get errRateLimited => 'Too many attempts. Please wait a moment.';

  @override
  String get errNotConfigured => 'Cloud sync is not set up in this build.';

  @override
  String get errDisabled => 'Sync is turned off.';

  @override
  String get cloudSignOut => 'Sign out';

  @override
  String get cloudSignOutNote => 'Signing out keeps all data on this device.';

  @override
  String get cloudDelete => 'Delete cloud account';

  @override
  String get cloudDeleteBody =>
      'This permanently deletes your cloud account and every synced record on the server. Data on this device is kept.';

  @override
  String get cloudDeleted => 'Cloud account deleted.';

  @override
  String get backupTitle => 'Backup';

  @override
  String get backupExport => 'Export backup';

  @override
  String get backupRestore => 'Restore from backup';

  @override
  String get backupNote =>
      'A backup is a JSON file with this profile\'s data. It does not include your recovery question, passwords or tokens. The file is not encrypted, so keep it somewhere private.';

  @override
  String get backupShareText => 'Nuvora backup';

  @override
  String backupPreview(String name, int rows) {
    return 'Backup of $name: $rows records';
  }

  @override
  String get backupAsNew => 'Restore as a new profile';

  @override
  String get backupAsNewNote => 'Safe: your current data is not changed.';

  @override
  String get backupReplace => 'Replace this profile\'s data';

  @override
  String get backupReplaceWarn =>
      'This permanently replaces everything in the current profile with the backup. It cannot be undone.';

  @override
  String get backupDone => 'Backup restored.';

  @override
  String get backupErrFormat => 'This is not a valid Nuvora backup.';

  @override
  String get backupErrNewer =>
      'This backup was made by a newer version of Nuvora.';

  @override
  String get backupErrLarge => 'This file is too large.';

  @override
  String get backupErrGeneric =>
      'The backup could not be restored. Nothing was changed.';

  @override
  String get privacyEncryption =>
      'Encryption: cloud traffic uses HTTPS. Data on this device relies on Android\'s app sandbox and device encryption; Nuvora does not add its own database encryption yet.';

  @override
  String get aiTitle => 'AI assistant (optional)';

  @override
  String get aiLabel => 'AI-generated';

  @override
  String get aiDisclaimer =>
      'AI can make mistakes. It is not a doctor, therapist, emergency service or religious authority. For medical or religious questions, ask a qualified professional or scholar. It never writes or changes Quran text.';

  @override
  String get aiConsentTitle => 'Use the AI assistant?';

  @override
  String get aiConsentBody =>
      'When you ask for help, the data you choose below is sent over HTTPS to Nuvora\'s server, which forwards it to an AI provider to write a reply. Your journal and your name are never sent. Requests are limited per day. You can turn this off at any time.';

  @override
  String get aiShareStudy => 'Share my study summary (minutes per subject)';

  @override
  String get aiShareFitness =>
      'Share my fitness summary (workouts and water days)';

  @override
  String get aiSharePrayer => 'Share my prayer tracking counts';

  @override
  String get aiEnable => 'Turn on the AI assistant';

  @override
  String get aiNeedsCloud =>
      'The AI assistant needs a cloud account and a configured server. You can still use the offline suggestion below.';

  @override
  String get aiOfflineTitle => 'Offline suggestion';

  @override
  String get aiCoachButton => 'Suggest goals for next week';

  @override
  String get aiToolsTitle => 'Study tools';

  @override
  String get aiNotesLabel => 'Your notes';

  @override
  String get aiNotesWarn =>
      'Text you enter here is sent to the AI service only when you press one of the buttons below.';

  @override
  String get aiDraftCards => 'Draft flashcards';

  @override
  String get aiSummarize => 'Summarize';

  @override
  String get aiQuestions => 'Practice questions';

  @override
  String get aiExplain => 'Explain';

  @override
  String get aiReviewCards =>
      'Review the drafts. Edit or untick any card before saving.';

  @override
  String aiSaveCards(int count) {
    return 'Save selected cards ($count)';
  }

  @override
  String get aiCardsSaved => 'Cards saved';

  @override
  String get aiHistory => 'Conversation history';

  @override
  String get aiHistoryEmpty => 'No history.';

  @override
  String get aiClearHistory => 'Clear history';

  @override
  String get aiHistoryCleared => 'History cleared';

  @override
  String get aiThinking => 'Thinking...';

  @override
  String get aiErrConsent => 'Turn on the AI assistant first.';

  @override
  String get aiErrTooSoon => 'Please wait a few seconds between requests.';

  @override
  String get aiErrRateLimited =>
      'The daily AI limit was reached. Try again tomorrow.';

  @override
  String get aiErrTooLong => 'That text is too long.';

  @override
  String get aiErrInvalid =>
      'The AI reply could not be used. Nothing was saved.';

  @override
  String get aiErrEmpty => 'Enter some notes first.';

  @override
  String get notifGenericBody => 'You have a reminder.';

  @override
  String notifPrayerBody(String prayer) {
    return 'It\'s time for $prayer.';
  }

  @override
  String get notifStudyBody => 'Time for a focus session.';

  @override
  String get notifWorkoutBody => 'Time to move.';

  @override
  String get notifHydrationBody => 'A glass of water?';

  @override
  String get notifReflectionBody => 'A moment to reflect on your day.';

  @override
  String get notifFlashcardsBody => 'Flashcards are ready to review.';

  @override
  String get notifWeeklyBody => 'Your weekly summary is ready.';

  @override
  String get notifTitle => 'Reminders';

  @override
  String get notifWhyTitle => 'Allow reminders?';

  @override
  String get notifWhyBody =>
      'Nuvora can remind you of prayer times, study sessions, workouts, water, reflection and your weekly summary. Reminders are scheduled on this device and work offline. You choose each one, and you can turn them all off.';

  @override
  String get notifAllow => 'Allow notifications';

  @override
  String get notifDeniedBody =>
      'Notifications are turned off for Nuvora. Turn them on in your phone\'s app settings to receive reminders.';

  @override
  String get notifSaved => 'Reminders updated';

  @override
  String get notifPrayer => 'Prayer times';

  @override
  String get notifPrayerNeedsLocation =>
      'Set your prayer location first so times can be calculated.';

  @override
  String notifOffset(int minutes) {
    return 'Remind me $minutes min before';
  }

  @override
  String get notifAtTime => 'Remind me at the prayer time';

  @override
  String get notifStudy => 'Study session';

  @override
  String get notifWorkout => 'Workout';

  @override
  String notifHydration(int hours) {
    return 'Water (every $hours h, daytime only)';
  }

  @override
  String get notifReflection => 'Daily reflection';

  @override
  String get notifFlashcards => 'Flashcard review (only when cards are due)';

  @override
  String get notifWeekly => 'Weekly summary';

  @override
  String get notifQuiet => 'Quiet hours';

  @override
  String get notifQuietNote =>
      'Quiet hours silence every reminder except prayer times, which you chose individually.';

  @override
  String get notifQuietOff => 'Off';

  @override
  String notifQuietRange(String start, String end) {
    return '$start to $end';
  }

  @override
  String get notifDetails => 'Show details in notifications';

  @override
  String get notifDetailsNote =>
      'Off by default: notifications say only that you have a reminder, so nothing personal appears on a locked screen.';

  @override
  String get notifExactNote =>
      'Reminders can arrive a few minutes late unless your phone allows exact alarms for Nuvora.';

  @override
  String get notifDay => 'Day of the week';

  @override
  String get notifTime => 'Time';

  @override
  String get weekdayMon => 'Monday';

  @override
  String get weekdayTue => 'Tuesday';

  @override
  String get weekdayWed => 'Wednesday';

  @override
  String get weekdayThu => 'Thursday';

  @override
  String get weekdayFri => 'Friday';

  @override
  String get weekdaySat => 'Saturday';

  @override
  String get weekdaySun => 'Sunday';
}
