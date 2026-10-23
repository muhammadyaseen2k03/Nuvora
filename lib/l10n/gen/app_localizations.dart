import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Nuvora'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Strengthen Your Body, Elevate Your Soul, Expand Your Mind.'**
  String get tagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get navPrayer;

  /// No description provided for @navStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get navStudy;

  /// No description provided for @navFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get navFitness;

  /// No description provided for @body.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get body;

  /// No description provided for @soul.
  ///
  /// In en, this message translates to:
  /// **'Soul'**
  String get soul;

  /// No description provided for @mind.
  ///
  /// In en, this message translates to:
  /// **'Mind'**
  String get mind;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String greetingMorning(String name);

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String greetingAfternoon(String name);

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String greetingEvening(String name);

  /// No description provided for @homeBuilding.
  ///
  /// In en, this message translates to:
  /// **'You\'re building consistency, one day at a time.'**
  String get homeBuilding;

  /// No description provided for @sectionComingTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming in the next phase'**
  String get sectionComingTitle;

  /// No description provided for @sectionComingBody.
  ///
  /// In en, this message translates to:
  /// **'This section is not built yet. Nothing here is saved or simulated.'**
  String get sectionComingBody;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profiles;

  /// No description provided for @activeProfile.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeProfile;

  /// No description provided for @switchProfile.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switchProfile;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add profile'**
  String get addProfile;

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete profile'**
  String get deleteProfile;

  /// No description provided for @deleteProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this profile?'**
  String get deleteProfileTitle;

  /// No description provided for @deleteProfileBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes the profile and all of its data from this device. It cannot be undone.'**
  String get deleteProfileBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get finish;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Nuvora'**
  String get welcomeTitle;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get nameTitle;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Preferred name'**
  String get nameHint;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get nameRequired;

  /// No description provided for @modeTitle.
  ///
  /// In en, this message translates to:
  /// **'Where should your data live?'**
  String get modeTitle;

  /// No description provided for @modeLocal.
  ///
  /// In en, this message translates to:
  /// **'On this device only'**
  String get modeLocal;

  /// No description provided for @modeLocalDesc.
  ///
  /// In en, this message translates to:
  /// **'Works fully offline. Nothing is uploaded.'**
  String get modeLocalDesc;

  /// No description provided for @modeCloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync'**
  String get modeCloud;

  /// No description provided for @modeCloudDesc.
  ///
  /// In en, this message translates to:
  /// **'Not available yet. Local mode works without it.'**
  String get modeCloudDesc;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your look'**
  String get themeTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get languageTitle;

  /// No description provided for @studyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily study goal'**
  String get studyTitle;

  /// No description provided for @studyMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min per day'**
  String studyMinutes(int minutes);

  /// No description provided for @fitnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get fitnessTitle;

  /// No description provided for @fitnessBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get fitnessBeginner;

  /// No description provided for @fitnessIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get fitnessIntermediate;

  /// No description provided for @fitnessAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get fitnessAdvanced;

  /// No description provided for @workoutMinutes.
  ///
  /// In en, this message translates to:
  /// **'Workout length: {minutes} min'**
  String workoutMinutes(int minutes);

  /// No description provided for @optionalLater.
  ///
  /// In en, this message translates to:
  /// **'You can change all of this later in Settings.'**
  String get optionalLater;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyLocalNote.
  ///
  /// In en, this message translates to:
  /// **'All data is stored locally on this device. Cloud sync and AI features are off and not yet available.'**
  String get privacyLocalNote;

  /// No description provided for @recoveryNote.
  ///
  /// In en, this message translates to:
  /// **'Local profiles have no server-side identity. A recovery question can only help on this device and cannot verify who you are.'**
  String get recoveryNote;

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @prayerNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {name}'**
  String prayerNext(String name);

  /// No description provided for @prayerNextFajrTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Next: Fajr (tomorrow)'**
  String get prayerNextFajrTomorrow;

  /// No description provided for @prayerIn.
  ///
  /// In en, this message translates to:
  /// **'in {time}'**
  String prayerIn(String time);

  /// No description provided for @prayerNeedLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your location'**
  String get prayerNeedLocationTitle;

  /// No description provided for @prayerNeedLocationBody.
  ///
  /// In en, this message translates to:
  /// **'Prayer times are calculated on this device from your location. You can pick a city or enter coordinates; no location permission is needed.'**
  String get prayerNeedLocationBody;

  /// No description provided for @prayerSetLocation.
  ///
  /// In en, this message translates to:
  /// **'Set location'**
  String get prayerSetLocation;

  /// No description provided for @prayerSettings.
  ///
  /// In en, this message translates to:
  /// **'Prayer settings'**
  String get prayerSettings;

  /// No description provided for @prayerMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation method'**
  String get prayerMethod;

  /// No description provided for @prayerAsrMethod.
  ///
  /// In en, this message translates to:
  /// **'Asr calculation'**
  String get prayerAsrMethod;

  /// No description provided for @prayerAsrStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard (earlier Asr)'**
  String get prayerAsrStandard;

  /// No description provided for @prayerAsrHanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi (later Asr)'**
  String get prayerAsrHanafi;

  /// No description provided for @prayerCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get prayerCity;

  /// No description provided for @prayerCustomLocation.
  ///
  /// In en, this message translates to:
  /// **'Custom coordinates'**
  String get prayerCustomLocation;

  /// No description provided for @prayerLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get prayerLatitude;

  /// No description provided for @prayerLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get prayerLongitude;

  /// No description provided for @prayerInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get prayerInvalidNumber;

  /// No description provided for @prayerLatRange.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90'**
  String get prayerLatRange;

  /// No description provided for @prayerLonRange.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get prayerLonRange;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @prayerDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Times are calculated and may differ from your local mosque timetable. Times are shown in this device\'s time zone.'**
  String get prayerDisclaimer;

  /// No description provided for @prayerStatusOnTime.
  ///
  /// In en, this message translates to:
  /// **'On time'**
  String get prayerStatusOnTime;

  /// No description provided for @prayerStatusLate.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get prayerStatusLate;

  /// No description provided for @prayerStatusMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get prayerStatusMissed;

  /// No description provided for @prayerStatusNone.
  ///
  /// In en, this message translates to:
  /// **'Not recorded'**
  String get prayerStatusNone;

  /// No description provided for @prayerStatusClear.
  ///
  /// In en, this message translates to:
  /// **'Clear record'**
  String get prayerStatusClear;

  /// No description provided for @prayerToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get prayerToday;

  /// No description provided for @prayerStreak.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No current streak} =1{1 day streak} other{{count} day streak}}'**
  String prayerStreak(int count);

  /// No description provided for @prayerLongest.
  ///
  /// In en, this message translates to:
  /// **'Longest: {count}'**
  String prayerLongest(int count);

  /// No description provided for @prayerStreakNote.
  ///
  /// In en, this message translates to:
  /// **'A day counts when all five prayers are recorded as completed. Days with prayers not recorded are not treated as missed.'**
  String get prayerStreakNote;

  /// No description provided for @prayerWeek.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get prayerWeek;

  /// No description provided for @prayerWeekSummary.
  ///
  /// In en, this message translates to:
  /// **'{completed} completed · {missed} missed · {unrecorded} not recorded'**
  String prayerWeekSummary(int completed, int missed, int unrecorded);

  /// No description provided for @prayerRecordFor.
  ///
  /// In en, this message translates to:
  /// **'Record {name}'**
  String prayerRecordFor(String name);

  /// No description provided for @studyTabFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get studyTabFocus;

  /// No description provided for @studyTabSubjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get studyTabSubjects;

  /// No description provided for @studyTabCards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get studyTabCards;

  /// No description provided for @focusKindFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focusKindFocus;

  /// No description provided for @focusKindShort.
  ///
  /// In en, this message translates to:
  /// **'Short break'**
  String get focusKindShort;

  /// No description provided for @focusKindLong.
  ///
  /// In en, this message translates to:
  /// **'Long break'**
  String get focusKindLong;

  /// No description provided for @focusMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String focusMinutes(int minutes);

  /// No description provided for @focusSubjectOptional.
  ///
  /// In en, this message translates to:
  /// **'Subject (optional)'**
  String get focusSubjectOptional;

  /// No description provided for @focusNoSubject.
  ///
  /// In en, this message translates to:
  /// **'No subject'**
  String get focusNoSubject;

  /// No description provided for @focusStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get focusStart;

  /// No description provided for @focusPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get focusPause;

  /// No description provided for @focusResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get focusResume;

  /// No description provided for @focusCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel session'**
  String get focusCancel;

  /// No description provided for @focusPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get focusPresets;

  /// No description provided for @focusTodaySummary.
  ///
  /// In en, this message translates to:
  /// **'Today: {count, plural, =0{no focus sessions yet} =1{1 focus session} other{{count} focus sessions}}, {minutes} min'**
  String focusTodaySummary(int count, int minutes);

  /// No description provided for @focusDone.
  ///
  /// In en, this message translates to:
  /// **'Session complete. Nicely done.'**
  String get focusDone;

  /// No description provided for @focusRecovered.
  ///
  /// In en, this message translates to:
  /// **'Your session kept running while the app was closed.'**
  String get focusRecovered;

  /// No description provided for @subjectsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No subjects yet. Add one to organize your syllabus.'**
  String get subjectsEmpty;

  /// No description provided for @subjectAdd.
  ///
  /// In en, this message translates to:
  /// **'Add subject'**
  String get subjectAdd;

  /// No description provided for @subjectName.
  ///
  /// In en, this message translates to:
  /// **'Subject name'**
  String get subjectName;

  /// No description provided for @subjectProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} topics completed'**
  String subjectProgress(int completed, int total);

  /// No description provided for @subjectDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This also deletes its topics. Flashcards keep existing but lose the subject link.'**
  String get subjectDeleteBody;

  /// No description provided for @topicAdd.
  ///
  /// In en, this message translates to:
  /// **'Add topic'**
  String get topicAdd;

  /// No description provided for @topicTitle.
  ///
  /// In en, this message translates to:
  /// **'Topic title'**
  String get topicTitle;

  /// No description provided for @topicPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get topicPriority;

  /// No description provided for @topicPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get topicPriorityHigh;

  /// No description provided for @topicPriorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get topicPriorityMedium;

  /// No description provided for @topicPriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get topicPriorityLow;

  /// No description provided for @topicEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated minutes (optional)'**
  String get topicEstimate;

  /// No description provided for @topicStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get topicStatusNotStarted;

  /// No description provided for @topicStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get topicStatusInProgress;

  /// No description provided for @topicStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get topicStatusCompleted;

  /// No description provided for @topicsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No topics yet. Break this subject into topics you can complete.'**
  String get topicsEmpty;

  /// No description provided for @examsTitle.
  ///
  /// In en, this message translates to:
  /// **'Upcoming exams'**
  String get examsTitle;

  /// No description provided for @examsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No upcoming exams.'**
  String get examsEmpty;

  /// No description provided for @examAdd.
  ///
  /// In en, this message translates to:
  /// **'Add exam'**
  String get examAdd;

  /// No description provided for @examName.
  ///
  /// In en, this message translates to:
  /// **'Exam name'**
  String get examName;

  /// No description provided for @examDate.
  ///
  /// In en, this message translates to:
  /// **'Exam date'**
  String get examDate;

  /// No description provided for @examDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Today} =1{Tomorrow} other{In {days} days}}'**
  String examDaysLeft(int days);

  /// No description provided for @cardsDue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No cards due} =1{1 card due} other{{count} cards due}}'**
  String cardsDue(int count);

  /// No description provided for @cardsReview.
  ///
  /// In en, this message translates to:
  /// **'Review cards'**
  String get cardsReview;

  /// No description provided for @cardAdd.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get cardAdd;

  /// No description provided for @cardFront.
  ///
  /// In en, this message translates to:
  /// **'Front (question)'**
  String get cardFront;

  /// No description provided for @cardBack.
  ///
  /// In en, this message translates to:
  /// **'Back (answer)'**
  String get cardBack;

  /// No description provided for @cardRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get cardRequired;

  /// No description provided for @cardsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No flashcards yet. Add your first card.'**
  String get cardsEmpty;

  /// No description provided for @cardArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get cardArchive;

  /// No description provided for @cardDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete card'**
  String get cardDelete;

  /// No description provided for @cardShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show answer'**
  String get cardShowAnswer;

  /// No description provided for @ratingAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get ratingAgain;

  /// No description provided for @ratingHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get ratingHard;

  /// No description provided for @ratingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get ratingGood;

  /// No description provided for @ratingEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get ratingEasy;

  /// No description provided for @reviewAllDone.
  ///
  /// In en, this message translates to:
  /// **'All caught up. No more cards are due.'**
  String get reviewAllDone;

  /// No description provided for @reviewProgress.
  ///
  /// In en, this message translates to:
  /// **'Card {current} of {total}'**
  String reviewProgress(int current, int total);

  /// No description provided for @cardsStats.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days: {reviews} reviews, {retention}% recalled'**
  String cardsStats(int reviews, int retention);

  /// No description provided for @cardsStatsNone.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet.'**
  String get cardsStatsNone;

  /// No description provided for @cardNextReview.
  ///
  /// In en, this message translates to:
  /// **'Next review: {date}'**
  String cardNextReview(String date);

  /// No description provided for @fitnessTabWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get fitnessTabWorkouts;

  /// No description provided for @fitnessTabWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get fitnessTabWater;

  /// No description provided for @fitnessTabFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get fitnessTabFasting;

  /// No description provided for @categoryFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full body'**
  String get categoryFullBody;

  /// No description provided for @categoryUpperBody.
  ///
  /// In en, this message translates to:
  /// **'Upper body'**
  String get categoryUpperBody;

  /// No description provided for @categoryLowerBody.
  ///
  /// In en, this message translates to:
  /// **'Lower body'**
  String get categoryLowerBody;

  /// No description provided for @categoryCore.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get categoryCore;

  /// No description provided for @categoryMobility.
  ///
  /// In en, this message translates to:
  /// **'Mobility'**
  String get categoryMobility;

  /// No description provided for @categoryQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick'**
  String get categoryQuick;

  /// No description provided for @workoutStart.
  ///
  /// In en, this message translates to:
  /// **'Start workout'**
  String get workoutStart;

  /// No description provided for @workoutReps.
  ///
  /// In en, this message translates to:
  /// **'{count} reps'**
  String workoutReps(int count);

  /// No description provided for @workoutSeconds.
  ///
  /// In en, this message translates to:
  /// **'{count} sec'**
  String workoutSeconds(int count);

  /// No description provided for @workoutRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get workoutRest;

  /// No description provided for @workoutUpNext.
  ///
  /// In en, this message translates to:
  /// **'Up next: {name}'**
  String workoutUpNext(String name);

  /// No description provided for @workoutEasier.
  ///
  /// In en, this message translates to:
  /// **'Easier option: {text}'**
  String workoutEasier(String text);

  /// No description provided for @workoutDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get workoutDone;

  /// No description provided for @workoutSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get workoutSkip;

  /// No description provided for @workoutPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get workoutPrevious;

  /// No description provided for @workoutEnd.
  ///
  /// In en, this message translates to:
  /// **'End workout'**
  String get workoutEnd;

  /// No description provided for @workoutComplete.
  ///
  /// In en, this message translates to:
  /// **'Workout complete'**
  String get workoutComplete;

  /// No description provided for @workoutSummary.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} exercises, {minutes} min'**
  String workoutSummary(int completed, int total, int minutes);

  /// No description provided for @workoutSafety.
  ///
  /// In en, this message translates to:
  /// **'Move at your own pace and stop if anything hurts. If you have a health condition or injury, check with a qualified professional first.'**
  String get workoutSafety;

  /// No description provided for @workoutHistory.
  ///
  /// In en, this message translates to:
  /// **'Recent workouts'**
  String get workoutHistory;

  /// No description provided for @workoutHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No workouts completed yet.'**
  String get workoutHistoryEmpty;

  /// No description provided for @waterToday.
  ///
  /// In en, this message translates to:
  /// **'{ml} of {goal} ml'**
  String waterToday(int ml, int goal);

  /// No description provided for @waterCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom amount'**
  String get waterCustom;

  /// No description provided for @waterAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount (ml)'**
  String get waterAmount;

  /// No description provided for @waterUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo last'**
  String get waterUndo;

  /// No description provided for @waterGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily goal (ml)'**
  String get waterGoal;

  /// No description provided for @waterGoalNote.
  ///
  /// In en, this message translates to:
  /// **'Your goal is personal and adjustable. It is not medical advice.'**
  String get waterGoalNote;

  /// No description provided for @waterHistory.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get waterHistory;

  /// No description provided for @waterAddMl.
  ///
  /// In en, this message translates to:
  /// **'Add {ml} ml'**
  String waterAddMl(int ml);

  /// No description provided for @fastStart.
  ///
  /// In en, this message translates to:
  /// **'Start fast'**
  String get fastStart;

  /// No description provided for @fastEnd.
  ///
  /// In en, this message translates to:
  /// **'End fast'**
  String get fastEnd;

  /// No description provided for @fastTarget.
  ///
  /// In en, this message translates to:
  /// **'Planned length'**
  String get fastTarget;

  /// No description provided for @fastNoTarget.
  ///
  /// In en, this message translates to:
  /// **'No target'**
  String get fastNoTarget;

  /// No description provided for @fastHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String fastHours(int hours);

  /// No description provided for @fastElapsed.
  ///
  /// In en, this message translates to:
  /// **'Elapsed'**
  String get fastElapsed;

  /// No description provided for @fastRemaining.
  ///
  /// In en, this message translates to:
  /// **'{time} remaining'**
  String fastRemaining(String time);

  /// No description provided for @fastGoalReached.
  ///
  /// In en, this message translates to:
  /// **'Planned length reached'**
  String get fastGoalReached;

  /// No description provided for @fastHistory.
  ///
  /// In en, this message translates to:
  /// **'Past fasts'**
  String get fastHistory;

  /// No description provided for @fastHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No fasts recorded yet.'**
  String get fastHistoryEmpty;

  /// No description provided for @fastSafety.
  ///
  /// In en, this message translates to:
  /// **'Fasting is not suitable for everyone. Stop if you feel unwell, and speak with a health professional if you have a medical condition, are pregnant, or take medication.'**
  String get fastSafety;

  /// No description provided for @homeScoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s progress'**
  String get homeScoreTitle;

  /// No description provided for @homeScoreNote.
  ///
  /// In en, this message translates to:
  /// **'Based on prayers recorded, study minutes, workout and water. It describes today\'s activity only, not your worth.'**
  String get homeScoreNote;

  /// No description provided for @tilePrayers.
  ///
  /// In en, this message translates to:
  /// **'Prayers'**
  String get tilePrayers;

  /// No description provided for @tileStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get tileStudy;

  /// No description provided for @tileWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get tileWorkout;

  /// No description provided for @tileWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get tileWater;

  /// No description provided for @tilePrayersValue.
  ///
  /// In en, this message translates to:
  /// **'{done} of 5'**
  String tilePrayersValue(int done);

  /// No description provided for @tileStudyValue.
  ///
  /// In en, this message translates to:
  /// **'{minutes} of {goal} min'**
  String tileStudyValue(int minutes, int goal);

  /// No description provided for @tileWorkoutDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get tileWorkoutDone;

  /// No description provided for @tileWorkoutNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get tileWorkoutNotYet;

  /// No description provided for @tileWaterValue.
  ///
  /// In en, this message translates to:
  /// **'{ml} of {goal} ml'**
  String tileWaterValue(int ml, int goal);

  /// No description provided for @homeNextPrayerAt.
  ///
  /// In en, this message translates to:
  /// **'{name} at {time}'**
  String homeNextPrayerAt(String name, String time);

  /// No description provided for @homeNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Set your prayer location to see times'**
  String get homeNoLocation;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActions;

  /// No description provided for @quickPrayer.
  ///
  /// In en, this message translates to:
  /// **'Log prayer'**
  String get quickPrayer;

  /// No description provided for @quickFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get quickFocus;

  /// No description provided for @quickWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get quickWorkout;

  /// No description provided for @quickWater.
  ///
  /// In en, this message translates to:
  /// **'+250 ml'**
  String get quickWater;

  /// No description provided for @homeOffline.
  ///
  /// In en, this message translates to:
  /// **'Everything works offline. Your data stays on this device.'**
  String get homeOffline;

  /// No description provided for @moreTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan and progress'**
  String get moreTitle;

  /// No description provided for @plannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily plan'**
  String get plannerTitle;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit calendar'**
  String get calendarTitle;

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get journalTitle;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @plannerGenerate.
  ///
  /// In en, this message translates to:
  /// **'Suggest a plan'**
  String get plannerGenerate;

  /// No description provided for @plannerRegenerate.
  ///
  /// In en, this message translates to:
  /// **'Update suggestions'**
  String get plannerRegenerate;

  /// No description provided for @plannerNote.
  ///
  /// In en, this message translates to:
  /// **'Suggestions are made on this device from your prayer times, exams, topics, due cards and workout length. Items you pin, complete or skip are kept when you update.'**
  String get plannerNote;

  /// No description provided for @plannerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No plan yet. Suggest one based on your day.'**
  String get plannerEmpty;

  /// No description provided for @plannerNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing to schedule right now. Add exams, topics or cards, or set a prayer location.'**
  String get plannerNothing;

  /// No description provided for @plannerAddOwn.
  ///
  /// In en, this message translates to:
  /// **'Add your own'**
  String get plannerAddOwn;

  /// No description provided for @plannerActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity name'**
  String get plannerActivityTitle;

  /// No description provided for @plannerStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get plannerStartTime;

  /// No description provided for @plannerEndTime.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get plannerEndTime;

  /// No description provided for @plannerEndAfterStart.
  ///
  /// In en, this message translates to:
  /// **'End must be after start'**
  String get plannerEndAfterStart;

  /// No description provided for @plannerPin.
  ///
  /// In en, this message translates to:
  /// **'Keep fixed'**
  String get plannerPin;

  /// No description provided for @plannerUnpin.
  ///
  /// In en, this message translates to:
  /// **'Allow changes'**
  String get plannerUnpin;

  /// No description provided for @plannerDone.
  ///
  /// In en, this message translates to:
  /// **'Mark done'**
  String get plannerDone;

  /// No description provided for @plannerSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get plannerSkip;

  /// No description provided for @plannerBegin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get plannerBegin;

  /// No description provided for @plannerReopen.
  ///
  /// In en, this message translates to:
  /// **'Back to planned'**
  String get plannerReopen;

  /// No description provided for @plannerRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get plannerRemove;

  /// No description provided for @plannerNotScheduled.
  ///
  /// In en, this message translates to:
  /// **'Could not fit: {titles}'**
  String plannerNotScheduled(String titles);

  /// No description provided for @reasonExamSoon.
  ///
  /// In en, this message translates to:
  /// **'Suggested because an exam is coming up.'**
  String get reasonExamSoon;

  /// No description provided for @reasonCardsDue.
  ///
  /// In en, this message translates to:
  /// **'Suggested because flashcards are due.'**
  String get reasonCardsDue;

  /// No description provided for @reasonTopicPending.
  ///
  /// In en, this message translates to:
  /// **'Suggested because this topic is not finished.'**
  String get reasonTopicPending;

  /// No description provided for @reasonWorkoutGoal.
  ///
  /// In en, this message translates to:
  /// **'Suggested to fit your workout length.'**
  String get reasonWorkoutGoal;

  /// No description provided for @statusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statusDone;

  /// No description provided for @statusSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get statusSkipped;

  /// No description provided for @calendarComplete.
  ///
  /// In en, this message translates to:
  /// **'All goals met'**
  String get calendarComplete;

  /// No description provided for @calendarPartial.
  ///
  /// In en, this message translates to:
  /// **'Partly done'**
  String get calendarPartial;

  /// No description provided for @calendarMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get calendarMissed;

  /// No description provided for @calendarUnrecorded.
  ///
  /// In en, this message translates to:
  /// **'Nothing recorded'**
  String get calendarUnrecorded;

  /// No description provided for @calendarLegend.
  ///
  /// In en, this message translates to:
  /// **'Complete = every goal met. Partly = something done. Missed = only missed prayers recorded. Empty = nothing recorded, which is not the same as missed.'**
  String get calendarLegend;

  /// No description provided for @dayDetailPrayers.
  ///
  /// In en, this message translates to:
  /// **'Prayers completed: {done} of 5'**
  String dayDetailPrayers(int done);

  /// No description provided for @dayDetailStudy.
  ///
  /// In en, this message translates to:
  /// **'Study: {minutes} min'**
  String dayDetailStudy(int minutes);

  /// No description provided for @dayDetailWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts: {count}'**
  String dayDetailWorkouts(int count);

  /// No description provided for @dayDetailWater.
  ///
  /// In en, this message translates to:
  /// **'Water: {ml} ml'**
  String dayDetailWater(int ml);

  /// No description provided for @journalToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s reflection'**
  String get journalToday;

  /// No description provided for @journalPromptWell.
  ///
  /// In en, this message translates to:
  /// **'What went well today?'**
  String get journalPromptWell;

  /// No description provided for @journalPromptLearned.
  ///
  /// In en, this message translates to:
  /// **'What did I learn?'**
  String get journalPromptLearned;

  /// No description provided for @journalPromptImprove.
  ///
  /// In en, this message translates to:
  /// **'What would I improve tomorrow?'**
  String get journalPromptImprove;

  /// No description provided for @journalPromptGrateful.
  ///
  /// In en, this message translates to:
  /// **'What am I grateful for?'**
  String get journalPromptGrateful;

  /// No description provided for @journalPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private. Stored only on this device and never shared with cloud or AI services.'**
  String get journalPrivate;

  /// No description provided for @journalSearch.
  ///
  /// In en, this message translates to:
  /// **'Search entries'**
  String get journalSearch;

  /// No description provided for @journalNoEntries.
  ///
  /// In en, this message translates to:
  /// **'No entries yet.'**
  String get journalNoEntries;

  /// No description provided for @journalSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get journalSaved;

  /// No description provided for @journalDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get journalDeleteTitle;

  /// No description provided for @journalDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes the entry from this device.'**
  String get journalDeleteBody;

  /// No description provided for @journalEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get journalEdit;

  /// No description provided for @progressLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String progressLevel(int level);

  /// No description provided for @progressXp.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String progressXp(int xp);

  /// No description provided for @progressXpNote.
  ///
  /// In en, this message translates to:
  /// **'XP: 10 per focus session, 20 per workout, 5 per prayer recorded as completed. Levels come every 200 XP. It is only a motivational counter.'**
  String get progressXpNote;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get badges;

  /// No description provided for @badgeEarned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get badgeEarned;

  /// No description provided for @badgePrayerStreak7.
  ///
  /// In en, this message translates to:
  /// **'Seven-day prayer tracking streak'**
  String get badgePrayerStreak7;

  /// No description provided for @badgeFocus10.
  ///
  /// In en, this message translates to:
  /// **'Ten focus sessions'**
  String get badgeFocus10;

  /// No description provided for @badgeStudy20h.
  ///
  /// In en, this message translates to:
  /// **'Twenty study hours this month'**
  String get badgeStudy20h;

  /// No description provided for @badgeWorkouts10.
  ///
  /// In en, this message translates to:
  /// **'Ten workouts'**
  String get badgeWorkouts10;

  /// No description provided for @badgeHydrationWeek.
  ///
  /// In en, this message translates to:
  /// **'A week of meeting your water goal'**
  String get badgeHydrationWeek;

  /// No description provided for @weeklyReport.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get weeklyReport;

  /// No description provided for @reportBestDay.
  ///
  /// In en, this message translates to:
  /// **'Most consistent day: {day}'**
  String reportBestDay(String day);

  /// No description provided for @reportNoBestDay.
  ///
  /// In en, this message translates to:
  /// **'No activity recorded yet this week.'**
  String get reportNoBestDay;

  /// No description provided for @reportStudy.
  ///
  /// In en, this message translates to:
  /// **'Study: {minutes} min'**
  String reportStudy(int minutes);

  /// No description provided for @reportWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts: {count}'**
  String reportWorkouts(int count);

  /// No description provided for @reportPrayers.
  ///
  /// In en, this message translates to:
  /// **'Prayers recorded as completed: {done} of {recorded} recorded'**
  String reportPrayers(int done, int recorded);

  /// No description provided for @reportWater.
  ///
  /// In en, this message translates to:
  /// **'Water goal met on {days} of 7 days'**
  String reportWater(int days);

  /// No description provided for @reportSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Next week: {text}'**
  String reportSuggestion(String text);

  /// No description provided for @suggestWater.
  ///
  /// In en, this message translates to:
  /// **'try a regular glass of water with each prayer or study break.'**
  String get suggestWater;

  /// No description provided for @suggestStudy.
  ///
  /// In en, this message translates to:
  /// **'schedule one short focus session at the same time each day.'**
  String get suggestStudy;

  /// No description provided for @suggestWorkout.
  ///
  /// In en, this message translates to:
  /// **'pick one short workout from the library for a fixed day.'**
  String get suggestWorkout;

  /// No description provided for @suggestPrayerTracking.
  ///
  /// In en, this message translates to:
  /// **'tap your prayers as you complete them so your history is complete.'**
  String get suggestPrayerTracking;

  /// No description provided for @suggestKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'keep the rhythm you have. Small steady steps count.'**
  String get suggestKeepGoing;

  /// No description provided for @cloudTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync (optional)'**
  String get cloudTitle;

  /// No description provided for @cloudNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync is not set up in this build. Everything works on this device without it.'**
  String get cloudNotConfigured;

  /// No description provided for @cloudIntro.
  ///
  /// In en, this message translates to:
  /// **'Sync copies the data you choose to your own account so you can use Nuvora on more than one device. It is off unless you turn it on.'**
  String get cloudIntro;

  /// No description provided for @cloudEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get cloudEmail;

  /// No description provided for @cloudPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get cloudPassword;

  /// No description provided for @cloudEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get cloudEmailInvalid;

  /// No description provided for @cloudPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get cloudPasswordShort;

  /// No description provided for @cloudSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get cloudSignIn;

  /// No description provided for @cloudCreate.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get cloudCreate;

  /// No description provided for @cloudForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get cloudForgot;

  /// No description provided for @cloudResetSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for that email, a reset link has been sent.'**
  String get cloudResetSent;

  /// No description provided for @cloudVerify.
  ///
  /// In en, this message translates to:
  /// **'Check your email to verify your account, then sign in.'**
  String get cloudVerify;

  /// No description provided for @cloudSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String cloudSignedInAs(String email);

  /// No description provided for @cloudSyncEnable.
  ///
  /// In en, this message translates to:
  /// **'Sync this profile'**
  String get cloudSyncEnable;

  /// No description provided for @cloudCatPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer tracking (private by default)'**
  String get cloudCatPrayer;

  /// No description provided for @cloudCatStudy.
  ///
  /// In en, this message translates to:
  /// **'Study data'**
  String get cloudCatStudy;

  /// No description provided for @cloudCatFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness data'**
  String get cloudCatFitness;

  /// No description provided for @cloudCatJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal entries (private)'**
  String get cloudCatJournal;

  /// No description provided for @cloudCatNote.
  ///
  /// In en, this message translates to:
  /// **'When sync is on, preferences, plans and achievements are always included. Never synced: your name, recovery question, notification settings and consent choices. Data is sent over HTTPS to your account; it is not end-to-end encrypted.'**
  String get cloudCatNote;

  /// No description provided for @cloudSyncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get cloudSyncNow;

  /// No description provided for @cloudSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get cloudSyncing;

  /// No description provided for @cloudLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last sync: {time}'**
  String cloudLastSync(String time);

  /// No description provided for @cloudNeverSynced.
  ///
  /// In en, this message translates to:
  /// **'Not synced yet'**
  String get cloudNeverSynced;

  /// No description provided for @cloudSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Last attempt failed: {reason}'**
  String cloudSyncFailed(String reason);

  /// No description provided for @cloudSyncDone.
  ///
  /// In en, this message translates to:
  /// **'Sync finished'**
  String get cloudSyncDone;

  /// No description provided for @cloudPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 change waiting to sync} other{{count} changes waiting to sync}}'**
  String cloudPending(int count);

  /// No description provided for @errOffline.
  ///
  /// In en, this message translates to:
  /// **'No connection. Your data is safe on this device.'**
  String get errOffline;

  /// No description provided for @errUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again.'**
  String get errUnauthorized;

  /// No description provided for @errServer.
  ///
  /// In en, this message translates to:
  /// **'The server had a problem. Try again later.'**
  String get errServer;

  /// No description provided for @errInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'The email or password is incorrect.'**
  String get errInvalidCredentials;

  /// No description provided for @errEmailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email first.'**
  String get errEmailNotVerified;

  /// No description provided for @errWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'That password is too weak.'**
  String get errWeakPassword;

  /// No description provided for @errEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'An account with that email already exists.'**
  String get errEmailTaken;

  /// No description provided for @errRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment.'**
  String get errRateLimited;

  /// No description provided for @errNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync is not set up in this build.'**
  String get errNotConfigured;

  /// No description provided for @errDisabled.
  ///
  /// In en, this message translates to:
  /// **'Sync is turned off.'**
  String get errDisabled;

  /// No description provided for @cloudSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get cloudSignOut;

  /// No description provided for @cloudSignOutNote.
  ///
  /// In en, this message translates to:
  /// **'Signing out keeps all data on this device.'**
  String get cloudSignOutNote;

  /// No description provided for @cloudDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete cloud account'**
  String get cloudDelete;

  /// No description provided for @cloudDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your cloud account and every synced record on the server. Data on this device is kept.'**
  String get cloudDeleteBody;

  /// No description provided for @cloudDeleted.
  ///
  /// In en, this message translates to:
  /// **'Cloud account deleted.'**
  String get cloudDeleted;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupTitle;

  /// No description provided for @backupExport.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get backupExport;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore from backup'**
  String get backupRestore;

  /// No description provided for @backupNote.
  ///
  /// In en, this message translates to:
  /// **'A backup is a JSON file with this profile\'s data. It does not include your recovery question, passwords or tokens. The file is not encrypted, so keep it somewhere private.'**
  String get backupNote;

  /// No description provided for @backupShareText.
  ///
  /// In en, this message translates to:
  /// **'Nuvora backup'**
  String get backupShareText;

  /// No description provided for @backupPreview.
  ///
  /// In en, this message translates to:
  /// **'Backup of {name}: {rows} records'**
  String backupPreview(String name, int rows);

  /// No description provided for @backupAsNew.
  ///
  /// In en, this message translates to:
  /// **'Restore as a new profile'**
  String get backupAsNew;

  /// No description provided for @backupAsNewNote.
  ///
  /// In en, this message translates to:
  /// **'Safe: your current data is not changed.'**
  String get backupAsNewNote;

  /// No description provided for @backupReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace this profile\'s data'**
  String get backupReplace;

  /// No description provided for @backupReplaceWarn.
  ///
  /// In en, this message translates to:
  /// **'This permanently replaces everything in the current profile with the backup. It cannot be undone.'**
  String get backupReplaceWarn;

  /// No description provided for @backupDone.
  ///
  /// In en, this message translates to:
  /// **'Backup restored.'**
  String get backupDone;

  /// No description provided for @backupErrFormat.
  ///
  /// In en, this message translates to:
  /// **'This is not a valid Nuvora backup.'**
  String get backupErrFormat;

  /// No description provided for @backupErrNewer.
  ///
  /// In en, this message translates to:
  /// **'This backup was made by a newer version of Nuvora.'**
  String get backupErrNewer;

  /// No description provided for @backupErrLarge.
  ///
  /// In en, this message translates to:
  /// **'This file is too large.'**
  String get backupErrLarge;

  /// No description provided for @backupErrGeneric.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored. Nothing was changed.'**
  String get backupErrGeneric;

  /// No description provided for @privacyEncryption.
  ///
  /// In en, this message translates to:
  /// **'Encryption: cloud traffic uses HTTPS. Data on this device relies on Android\'s app sandbox and device encryption; Nuvora does not add its own database encryption yet.'**
  String get privacyEncryption;

  /// No description provided for @aiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI assistant (optional)'**
  String get aiTitle;

  /// No description provided for @aiLabel.
  ///
  /// In en, this message translates to:
  /// **'AI-generated'**
  String get aiLabel;

  /// No description provided for @aiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AI can make mistakes. It is not a doctor, therapist, emergency service or religious authority. For medical or religious questions, ask a qualified professional or scholar. It never writes or changes Quran text.'**
  String get aiDisclaimer;

  /// No description provided for @aiConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Use the AI assistant?'**
  String get aiConsentTitle;

  /// No description provided for @aiConsentBody.
  ///
  /// In en, this message translates to:
  /// **'When you ask for help, the data you choose below is sent over HTTPS to Nuvora\'s server, which forwards it to an AI provider to write a reply. Your journal and your name are never sent. Requests are limited per day. You can turn this off at any time.'**
  String get aiConsentBody;

  /// No description provided for @aiShareStudy.
  ///
  /// In en, this message translates to:
  /// **'Share my study summary (minutes per subject)'**
  String get aiShareStudy;

  /// No description provided for @aiShareFitness.
  ///
  /// In en, this message translates to:
  /// **'Share my fitness summary (workouts and water days)'**
  String get aiShareFitness;

  /// No description provided for @aiSharePrayer.
  ///
  /// In en, this message translates to:
  /// **'Share my prayer tracking counts'**
  String get aiSharePrayer;

  /// No description provided for @aiEnable.
  ///
  /// In en, this message translates to:
  /// **'Turn on the AI assistant'**
  String get aiEnable;

  /// No description provided for @aiNeedsCloud.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant needs a cloud account and a configured server. You can still use the offline suggestion below.'**
  String get aiNeedsCloud;

  /// No description provided for @aiOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline suggestion'**
  String get aiOfflineTitle;

  /// No description provided for @aiCoachButton.
  ///
  /// In en, this message translates to:
  /// **'Suggest goals for next week'**
  String get aiCoachButton;

  /// No description provided for @aiToolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Study tools'**
  String get aiToolsTitle;

  /// No description provided for @aiNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Your notes'**
  String get aiNotesLabel;

  /// No description provided for @aiNotesWarn.
  ///
  /// In en, this message translates to:
  /// **'Text you enter here is sent to the AI service only when you press one of the buttons below.'**
  String get aiNotesWarn;

  /// No description provided for @aiDraftCards.
  ///
  /// In en, this message translates to:
  /// **'Draft flashcards'**
  String get aiDraftCards;

  /// No description provided for @aiSummarize.
  ///
  /// In en, this message translates to:
  /// **'Summarize'**
  String get aiSummarize;

  /// No description provided for @aiQuestions.
  ///
  /// In en, this message translates to:
  /// **'Practice questions'**
  String get aiQuestions;

  /// No description provided for @aiExplain.
  ///
  /// In en, this message translates to:
  /// **'Explain'**
  String get aiExplain;

  /// No description provided for @aiReviewCards.
  ///
  /// In en, this message translates to:
  /// **'Review the drafts. Edit or untick any card before saving.'**
  String get aiReviewCards;

  /// No description provided for @aiSaveCards.
  ///
  /// In en, this message translates to:
  /// **'Save selected cards ({count})'**
  String aiSaveCards(int count);

  /// No description provided for @aiCardsSaved.
  ///
  /// In en, this message translates to:
  /// **'Cards saved'**
  String get aiCardsSaved;

  /// No description provided for @aiHistory.
  ///
  /// In en, this message translates to:
  /// **'Conversation history'**
  String get aiHistory;

  /// No description provided for @aiHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history.'**
  String get aiHistoryEmpty;

  /// No description provided for @aiClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get aiClearHistory;

  /// No description provided for @aiHistoryCleared.
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get aiHistoryCleared;

  /// No description provided for @aiThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get aiThinking;

  /// No description provided for @aiErrConsent.
  ///
  /// In en, this message translates to:
  /// **'Turn on the AI assistant first.'**
  String get aiErrConsent;

  /// No description provided for @aiErrTooSoon.
  ///
  /// In en, this message translates to:
  /// **'Please wait a few seconds between requests.'**
  String get aiErrTooSoon;

  /// No description provided for @aiErrRateLimited.
  ///
  /// In en, this message translates to:
  /// **'The daily AI limit was reached. Try again tomorrow.'**
  String get aiErrRateLimited;

  /// No description provided for @aiErrTooLong.
  ///
  /// In en, this message translates to:
  /// **'That text is too long.'**
  String get aiErrTooLong;

  /// No description provided for @aiErrInvalid.
  ///
  /// In en, this message translates to:
  /// **'The AI reply could not be used. Nothing was saved.'**
  String get aiErrInvalid;

  /// No description provided for @aiErrEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter some notes first.'**
  String get aiErrEmpty;

  /// No description provided for @notifGenericBody.
  ///
  /// In en, this message translates to:
  /// **'You have a reminder.'**
  String get notifGenericBody;

  /// No description provided for @notifPrayerBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s time for {prayer}.'**
  String notifPrayerBody(String prayer);

  /// No description provided for @notifStudyBody.
  ///
  /// In en, this message translates to:
  /// **'Time for a focus session.'**
  String get notifStudyBody;

  /// No description provided for @notifWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'Time to move.'**
  String get notifWorkoutBody;

  /// No description provided for @notifHydrationBody.
  ///
  /// In en, this message translates to:
  /// **'A glass of water?'**
  String get notifHydrationBody;

  /// No description provided for @notifReflectionBody.
  ///
  /// In en, this message translates to:
  /// **'A moment to reflect on your day.'**
  String get notifReflectionBody;

  /// No description provided for @notifFlashcardsBody.
  ///
  /// In en, this message translates to:
  /// **'Flashcards are ready to review.'**
  String get notifFlashcardsBody;

  /// No description provided for @notifWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'Your weekly summary is ready.'**
  String get notifWeeklyBody;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notifTitle;

  /// No description provided for @notifWhyTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow reminders?'**
  String get notifWhyTitle;

  /// No description provided for @notifWhyBody.
  ///
  /// In en, this message translates to:
  /// **'Nuvora can remind you of prayer times, study sessions, workouts, water, reflection and your weekly summary. Reminders are scheduled on this device and work offline. You choose each one, and you can turn them all off.'**
  String get notifWhyBody;

  /// No description provided for @notifAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get notifAllow;

  /// No description provided for @notifDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Nuvora. Turn them on in your phone\'s app settings to receive reminders.'**
  String get notifDeniedBody;

  /// No description provided for @notifSaved.
  ///
  /// In en, this message translates to:
  /// **'Reminders updated'**
  String get notifSaved;

  /// No description provided for @notifPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer times'**
  String get notifPrayer;

  /// No description provided for @notifPrayerNeedsLocation.
  ///
  /// In en, this message translates to:
  /// **'Set your prayer location first so times can be calculated.'**
  String get notifPrayerNeedsLocation;

  /// No description provided for @notifOffset.
  ///
  /// In en, this message translates to:
  /// **'Remind me {minutes} min before'**
  String notifOffset(int minutes);

  /// No description provided for @notifAtTime.
  ///
  /// In en, this message translates to:
  /// **'Remind me at the prayer time'**
  String get notifAtTime;

  /// No description provided for @notifStudy.
  ///
  /// In en, this message translates to:
  /// **'Study session'**
  String get notifStudy;

  /// No description provided for @notifWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get notifWorkout;

  /// No description provided for @notifHydration.
  ///
  /// In en, this message translates to:
  /// **'Water (every {hours} h, daytime only)'**
  String notifHydration(int hours);

  /// No description provided for @notifReflection.
  ///
  /// In en, this message translates to:
  /// **'Daily reflection'**
  String get notifReflection;

  /// No description provided for @notifFlashcards.
  ///
  /// In en, this message translates to:
  /// **'Flashcard review (only when cards are due)'**
  String get notifFlashcards;

  /// No description provided for @notifWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get notifWeekly;

  /// No description provided for @notifQuiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours'**
  String get notifQuiet;

  /// No description provided for @notifQuietNote.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours silence every reminder except prayer times, which you chose individually.'**
  String get notifQuietNote;

  /// No description provided for @notifQuietOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get notifQuietOff;

  /// No description provided for @notifQuietRange.
  ///
  /// In en, this message translates to:
  /// **'{start} to {end}'**
  String notifQuietRange(String start, String end);

  /// No description provided for @notifDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details in notifications'**
  String get notifDetails;

  /// No description provided for @notifDetailsNote.
  ///
  /// In en, this message translates to:
  /// **'Off by default: notifications say only that you have a reminder, so nothing personal appears on a locked screen.'**
  String get notifDetailsNote;

  /// No description provided for @notifExactNote.
  ///
  /// In en, this message translates to:
  /// **'Reminders can arrive a few minutes late unless your phone allows exact alarms for Nuvora.'**
  String get notifExactNote;

  /// No description provided for @notifDay.
  ///
  /// In en, this message translates to:
  /// **'Day of the week'**
  String get notifDay;

  /// No description provided for @notifTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get notifTime;

  /// No description provided for @weekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySun;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
