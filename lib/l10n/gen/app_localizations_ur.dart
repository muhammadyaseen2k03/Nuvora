// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'نووورا';

  @override
  String get tagline => 'جسم کو مضبوط کریں، روح کو بلند کریں، ذہن کو وسعت دیں۔';

  @override
  String get navHome => 'ہوم';

  @override
  String get navPrayer => 'نماز';

  @override
  String get navStudy => 'مطالعہ';

  @override
  String get navFitness => 'فٹنس';

  @override
  String get body => 'جسم';

  @override
  String get soul => 'روح';

  @override
  String get mind => 'ذہن';

  @override
  String greetingMorning(String name) {
    return 'صبح بخیر، $name';
  }

  @override
  String greetingAfternoon(String name) {
    return 'السلام علیکم، $name';
  }

  @override
  String greetingEvening(String name) {
    return 'شام بخیر، $name';
  }

  @override
  String get homeBuilding => 'آپ روز بہ روز تسلسل بنا رہے ہیں۔';

  @override
  String get sectionComingTitle => 'اگلے مرحلے میں آ رہا ہے';

  @override
  String get sectionComingBody =>
      'یہ حصہ ابھی تیار نہیں ہوا۔ یہاں کچھ محفوظ یا فرضی نہیں ہے۔';

  @override
  String get settings => 'ترتیبات';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get language => 'زبان';

  @override
  String get profiles => 'پروفائلز';

  @override
  String get activeProfile => 'فعال';

  @override
  String get switchProfile => 'تبدیل کریں';

  @override
  String get addProfile => 'پروفائل شامل کریں';

  @override
  String get deleteProfile => 'پروفائل حذف کریں';

  @override
  String get deleteProfileTitle => 'یہ پروفائل حذف کریں؟';

  @override
  String get deleteProfileBody =>
      'یہ پروفائل اور اس کا تمام ڈیٹا اس آلے سے مستقل طور پر ہٹا دے گا۔ اسے واپس نہیں کیا جا سکتا۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get next => 'آگے';

  @override
  String get back => 'پیچھے';

  @override
  String get skip => 'چھوڑیں';

  @override
  String get finish => 'شروع کریں';

  @override
  String get welcomeTitle => 'نووورا میں خوش آمدید';

  @override
  String get nameTitle => 'ہم آپ کو کیا کہہ کر پکاریں؟';

  @override
  String get nameHint => 'پسندیدہ نام';

  @override
  String get nameRequired => 'براہ کرم نام درج کریں';

  @override
  String get modeTitle => 'آپ کا ڈیٹا کہاں رہے؟';

  @override
  String get modeLocal => 'صرف اس آلے پر';

  @override
  String get modeLocalDesc => 'مکمل آف لائن کام کرتا ہے۔ کچھ اپ لوڈ نہیں ہوتا۔';

  @override
  String get modeCloud => 'کلاؤڈ سنک';

  @override
  String get modeCloudDesc =>
      'ابھی دستیاب نہیں۔ مقامی موڈ اس کے بغیر کام کرتا ہے۔';

  @override
  String get themeTitle => 'اپنی پسند کی شکل چنیں';

  @override
  String get languageTitle => 'اپنی زبان چنیں';

  @override
  String get studyTitle => 'روزانہ مطالعے کا ہدف';

  @override
  String studyMinutes(int minutes) {
    return 'روزانہ $minutes منٹ';
  }

  @override
  String get fitnessTitle => 'فٹنس';

  @override
  String get fitnessBeginner => 'ابتدائی';

  @override
  String get fitnessIntermediate => 'درمیانی';

  @override
  String get fitnessAdvanced => 'ماہر';

  @override
  String workoutMinutes(int minutes) {
    return 'ورزش کا دورانیہ: $minutes منٹ';
  }

  @override
  String get optionalLater => 'آپ یہ سب بعد میں ترتیبات میں بدل سکتے ہیں۔';

  @override
  String get privacy => 'رازداری';

  @override
  String get privacyLocalNote =>
      'تمام ڈیٹا اسی آلے پر محفوظ ہے۔ کلاؤڈ سنک اور اے آئی فیچرز بند ہیں اور ابھی دستیاب نہیں۔';

  @override
  String get recoveryNote =>
      'مقامی پروفائلز کی کوئی سرور سائیڈ شناخت نہیں ہوتی۔ بازیابی کا سوال صرف اسی آلے پر مدد کر سکتا ہے اور آپ کی شناخت کی تصدیق نہیں کرتا۔';

  @override
  String get prayerFajr => 'فجر';

  @override
  String get prayerDhuhr => 'ظہر';

  @override
  String get prayerAsr => 'عصر';

  @override
  String get prayerMaghrib => 'مغرب';

  @override
  String get prayerIsha => 'عشاء';

  @override
  String prayerNext(String name) {
    return 'اگلی: $name';
  }

  @override
  String get prayerNextFajrTomorrow => 'اگلی: فجر (کل)';

  @override
  String prayerIn(String time) {
    return '$time میں';
  }

  @override
  String get prayerNeedLocationTitle => 'اپنا مقام چنیں';

  @override
  String get prayerNeedLocationBody =>
      'نماز کے اوقات اس آلے پر آپ کے مقام سے شمار ہوتے ہیں۔ آپ شہر چن سکتے ہیں یا نقاط درج کر سکتے ہیں؛ مقام کی اجازت ضروری نہیں۔';

  @override
  String get prayerSetLocation => 'مقام مقرر کریں';

  @override
  String get prayerSettings => 'نماز کی ترتیبات';

  @override
  String get prayerMethod => 'شمار کا طریقہ';

  @override
  String get prayerAsrMethod => 'عصر کا حساب';

  @override
  String get prayerAsrStandard => 'معیاری (پہلے عصر)';

  @override
  String get prayerAsrHanafi => 'حنفی (بعد کا عصر)';

  @override
  String get prayerCity => 'شہر';

  @override
  String get prayerCustomLocation => 'اپنے نقاط';

  @override
  String get prayerLatitude => 'عرض بلد';

  @override
  String get prayerLongitude => 'طول بلد';

  @override
  String get prayerInvalidNumber => 'درست عدد درج کریں';

  @override
  String get prayerLatRange => 'عرض بلد -90 سے 90 کے درمیان ہونا چاہیے';

  @override
  String get prayerLonRange => 'طول بلد -180 سے 180 کے درمیان ہونا چاہیے';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get prayerDisclaimer =>
      'اوقات شمار کیے گئے ہیں اور آپ کی مقامی مسجد کے نظام الاوقات سے مختلف ہو سکتے ہیں۔ اوقات اس آلے کے ٹائم زون میں دکھائے گئے ہیں۔';

  @override
  String get prayerStatusOnTime => 'وقت پر';

  @override
  String get prayerStatusLate => 'تاخیر سے';

  @override
  String get prayerStatusMissed => 'رہ گئی';

  @override
  String get prayerStatusNone => 'درج نہیں';

  @override
  String get prayerStatusClear => 'اندراج ہٹائیں';

  @override
  String get prayerToday => 'آج';

  @override
  String prayerStreak(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دن کا سلسلہ',
      one: '1 دن کا سلسلہ',
      zero: 'کوئی موجودہ سلسلہ نہیں',
    );
    return '$_temp0';
  }

  @override
  String prayerLongest(int count) {
    return 'طویل ترین: $count';
  }

  @override
  String get prayerStreakNote =>
      'دن تب شمار ہوتا ہے جب پانچوں نمازیں ادا شدہ درج ہوں۔ جن نمازوں کا اندراج نہیں، انہیں رہ گئی نہیں سمجھا جاتا۔';

  @override
  String get prayerWeek => 'پچھلے 7 دن';

  @override
  String prayerWeekSummary(int completed, int missed, int unrecorded) {
    return '$completed ادا · $missed رہ گئیں · $unrecorded درج نہیں';
  }

  @override
  String prayerRecordFor(String name) {
    return '$name درج کریں';
  }

  @override
  String get studyTabFocus => 'توجہ';

  @override
  String get studyTabSubjects => 'مضامین';

  @override
  String get studyTabCards => 'کارڈز';

  @override
  String get focusKindFocus => 'توجہ';

  @override
  String get focusKindShort => 'مختصر وقفہ';

  @override
  String get focusKindLong => 'طویل وقفہ';

  @override
  String focusMinutes(int minutes) {
    return '$minutes منٹ';
  }

  @override
  String get focusSubjectOptional => 'مضمون (اختیاری)';

  @override
  String get focusNoSubject => 'کوئی مضمون نہیں';

  @override
  String get focusStart => 'شروع کریں';

  @override
  String get focusPause => 'روکیں';

  @override
  String get focusResume => 'جاری رکھیں';

  @override
  String get focusCancel => 'سیشن منسوخ کریں';

  @override
  String get focusPresets => 'پہلے سے طے شدہ';

  @override
  String focusTodaySummary(int count, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count توجہ سیشن',
      one: '1 توجہ سیشن',
      zero: 'ابھی کوئی توجہ سیشن نہیں',
    );
    return 'آج: $_temp0، $minutes منٹ';
  }

  @override
  String get focusDone => 'سیشن مکمل ہوا۔ شاباش۔';

  @override
  String get focusRecovered => 'ایپ بند ہونے کے دوران آپ کا سیشن چلتا رہا۔';

  @override
  String get subjectsEmpty =>
      'ابھی کوئی مضمون نہیں۔ نصاب ترتیب دینے کے لیے ایک شامل کریں۔';

  @override
  String get subjectAdd => 'مضمون شامل کریں';

  @override
  String get subjectName => 'مضمون کا نام';

  @override
  String subjectProgress(int completed, int total) {
    return '$total میں سے $completed موضوعات مکمل';
  }

  @override
  String get subjectDeleteBody =>
      'اس سے اس کے موضوعات بھی حذف ہو جائیں گے۔ فلیش کارڈز رہیں گے مگر مضمون سے رشتہ ختم ہو جائے گا۔';

  @override
  String get topicAdd => 'موضوع شامل کریں';

  @override
  String get topicTitle => 'موضوع کا عنوان';

  @override
  String get topicPriority => 'ترجیح';

  @override
  String get topicPriorityHigh => 'زیادہ';

  @override
  String get topicPriorityMedium => 'درمیانی';

  @override
  String get topicPriorityLow => 'کم';

  @override
  String get topicEstimate => 'اندازاً منٹ (اختیاری)';

  @override
  String get topicStatusNotStarted => 'شروع نہیں ہوا';

  @override
  String get topicStatusInProgress => 'جاری';

  @override
  String get topicStatusCompleted => 'مکمل';

  @override
  String get topicsEmpty =>
      'ابھی کوئی موضوع نہیں۔ اس مضمون کو قابل تکمیل موضوعات میں تقسیم کریں۔';

  @override
  String get examsTitle => 'آنے والے امتحانات';

  @override
  String get examsEmpty => 'کوئی آنے والا امتحان نہیں۔';

  @override
  String get examAdd => 'امتحان شامل کریں';

  @override
  String get examName => 'امتحان کا نام';

  @override
  String get examDate => 'امتحان کی تاریخ';

  @override
  String examDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days دن بعد',
      one: 'کل',
      zero: 'آج',
    );
    return '$_temp0';
  }

  @override
  String cardsDue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count کارڈ واجب',
      one: '1 کارڈ واجب',
      zero: 'کوئی کارڈ واجب نہیں',
    );
    return '$_temp0';
  }

  @override
  String get cardsReview => 'کارڈز دہرائیں';

  @override
  String get cardAdd => 'کارڈ شامل کریں';

  @override
  String get cardFront => 'سامنے (سوال)';

  @override
  String get cardBack => 'پیچھے (جواب)';

  @override
  String get cardRequired => 'یہ خانہ ضروری ہے';

  @override
  String get cardsEmpty =>
      'ابھی کوئی فلیش کارڈ نہیں۔ اپنا پہلا کارڈ شامل کریں۔';

  @override
  String get cardArchive => 'محفوظ شدہ میں رکھیں';

  @override
  String get cardDelete => 'کارڈ حذف کریں';

  @override
  String get cardShowAnswer => 'جواب دکھائیں';

  @override
  String get ratingAgain => 'دوبارہ';

  @override
  String get ratingHard => 'مشکل';

  @override
  String get ratingGood => 'اچھا';

  @override
  String get ratingEasy => 'آسان';

  @override
  String get reviewAllDone => 'سب مکمل۔ مزید کوئی کارڈ واجب نہیں۔';

  @override
  String reviewProgress(int current, int total) {
    return 'کارڈ $current از $total';
  }

  @override
  String cardsStats(int reviews, int retention) {
    return 'پچھلے 30 دن: $reviews جائزے، $retention% یاد رہا';
  }

  @override
  String get cardsStatsNone => 'ابھی کوئی جائزہ نہیں۔';

  @override
  String cardNextReview(String date) {
    return 'اگلا جائزہ: $date';
  }

  @override
  String get fitnessTabWorkouts => 'ورزشیں';

  @override
  String get fitnessTabWater => 'پانی';

  @override
  String get fitnessTabFasting => 'روزہ';

  @override
  String get categoryFullBody => 'پورا جسم';

  @override
  String get categoryUpperBody => 'اوپری جسم';

  @override
  String get categoryLowerBody => 'نچلا جسم';

  @override
  String get categoryCore => 'کور';

  @override
  String get categoryMobility => 'لچک';

  @override
  String get categoryQuick => 'مختصر';

  @override
  String get workoutStart => 'ورزش شروع کریں';

  @override
  String workoutReps(int count) {
    return '$count بار';
  }

  @override
  String workoutSeconds(int count) {
    return '$count سیکنڈ';
  }

  @override
  String get workoutRest => 'آرام';

  @override
  String workoutUpNext(String name) {
    return 'اگلی: $name';
  }

  @override
  String workoutEasier(String text) {
    return 'آسان طریقہ: $text';
  }

  @override
  String get workoutDone => 'مکمل';

  @override
  String get workoutSkip => 'چھوڑیں';

  @override
  String get workoutPrevious => 'پچھلی';

  @override
  String get workoutEnd => 'ورزش ختم کریں';

  @override
  String get workoutComplete => 'ورزش مکمل';

  @override
  String workoutSummary(int completed, int total, int minutes) {
    return '$total میں سے $completed مشقیں، $minutes منٹ';
  }

  @override
  String get workoutSafety =>
      'اپنی رفتار سے کریں اور کسی بھی تکلیف پر رک جائیں۔ اگر آپ کو کوئی طبی مسئلہ یا چوٹ ہے تو پہلے کسی ماہر سے مشورہ کریں۔';

  @override
  String get workoutHistory => 'حالیہ ورزشیں';

  @override
  String get workoutHistoryEmpty => 'ابھی کوئی ورزش مکمل نہیں ہوئی۔';

  @override
  String waterToday(int ml, int goal) {
    return '$goal ملی لیٹر میں سے $ml';
  }

  @override
  String get waterCustom => 'اپنی مقدار';

  @override
  String get waterAmount => 'مقدار (ملی لیٹر)';

  @override
  String get waterUndo => 'آخری واپس لیں';

  @override
  String get waterGoal => 'روزانہ ہدف (ملی لیٹر)';

  @override
  String get waterGoalNote =>
      'آپ کا ہدف ذاتی اور قابل تبدیلی ہے۔ یہ طبی مشورہ نہیں ہے۔';

  @override
  String get waterHistory => 'پچھلے 7 دن';

  @override
  String waterAddMl(int ml) {
    return '$ml ملی لیٹر شامل کریں';
  }

  @override
  String get fastStart => 'روزہ شروع کریں';

  @override
  String get fastEnd => 'روزہ ختم کریں';

  @override
  String get fastTarget => 'مقررہ دورانیہ';

  @override
  String get fastNoTarget => 'کوئی ہدف نہیں';

  @override
  String fastHours(int hours) {
    return '$hours گھنٹے';
  }

  @override
  String get fastElapsed => 'گزرا وقت';

  @override
  String fastRemaining(String time) {
    return '$time باقی';
  }

  @override
  String get fastGoalReached => 'مقررہ دورانیہ پورا ہوا';

  @override
  String get fastHistory => 'پچھلے روزے';

  @override
  String get fastHistoryEmpty => 'ابھی کوئی روزہ درج نہیں۔';

  @override
  String get fastSafety =>
      'روزہ ہر ایک کے لیے موزوں نہیں۔ طبیعت خراب ہو تو رک جائیں، اور اگر آپ کو کوئی طبی مسئلہ ہے، حاملہ ہیں یا دوا لیتے ہیں تو کسی ماہر صحت سے بات کریں۔';

  @override
  String get homeScoreTitle => 'آج کی پیش رفت';

  @override
  String get homeScoreNote =>
      'درج شدہ نمازوں، مطالعے کے منٹوں، ورزش اور پانی پر مبنی۔ یہ صرف آج کی سرگرمی بتاتا ہے، آپ کی قدر نہیں۔';

  @override
  String get tilePrayers => 'نمازیں';

  @override
  String get tileStudy => 'مطالعہ';

  @override
  String get tileWorkout => 'ورزش';

  @override
  String get tileWater => 'پانی';

  @override
  String tilePrayersValue(int done) {
    return '5 میں سے $done';
  }

  @override
  String tileStudyValue(int minutes, int goal) {
    return '$goal میں سے $minutes منٹ';
  }

  @override
  String get tileWorkoutDone => 'مکمل';

  @override
  String get tileWorkoutNotYet => 'ابھی نہیں';

  @override
  String tileWaterValue(int ml, int goal) {
    return '$goal میں سے $ml ملی لیٹر';
  }

  @override
  String homeNextPrayerAt(String name, String time) {
    return '$name بوقت $time';
  }

  @override
  String get homeNoLocation => 'اوقات دیکھنے کے لیے نماز کا مقام مقرر کریں';

  @override
  String get quickActions => 'فوری اقدامات';

  @override
  String get quickPrayer => 'نماز درج کریں';

  @override
  String get quickFocus => 'توجہ';

  @override
  String get quickWorkout => 'ورزش';

  @override
  String get quickWater => '+250 ملی لیٹر';

  @override
  String get homeOffline =>
      'سب کچھ آف لائن کام کرتا ہے۔ آپ کا ڈیٹا اسی آلے پر رہتا ہے۔';

  @override
  String get moreTitle => 'منصوبہ اور پیش رفت';

  @override
  String get plannerTitle => 'روزانہ منصوبہ';

  @override
  String get calendarTitle => 'عادات کا کیلنڈر';

  @override
  String get journalTitle => 'غور و فکر';

  @override
  String get progressTitle => 'پیش رفت';

  @override
  String get plannerGenerate => 'منصوبہ تجویز کریں';

  @override
  String get plannerRegenerate => 'تجاویز اپڈیٹ کریں';

  @override
  String get plannerNote =>
      'تجاویز اس آلے پر آپ کے نماز کے اوقات، امتحانات، موضوعات، واجب کارڈز اور ورزش کے دورانیے سے بنتی ہیں۔ جو آئٹمز آپ پن کریں، مکمل کریں یا چھوڑیں وہ اپڈیٹ پر برقرار رہتے ہیں۔';

  @override
  String get plannerEmpty =>
      'ابھی کوئی منصوبہ نہیں۔ اپنے دن کے مطابق ایک تجویز کریں۔';

  @override
  String get plannerNothing =>
      'ابھی شیڈول کرنے کو کچھ نہیں۔ امتحانات، موضوعات یا کارڈز شامل کریں، یا نماز کا مقام مقرر کریں۔';

  @override
  String get plannerAddOwn => 'اپنا شامل کریں';

  @override
  String get plannerActivityTitle => 'سرگرمی کا نام';

  @override
  String get plannerStartTime => 'آغاز کا وقت';

  @override
  String get plannerEndTime => 'اختتام کا وقت';

  @override
  String get plannerEndAfterStart => 'اختتام آغاز کے بعد ہونا چاہیے';

  @override
  String get plannerPin => 'مقرر رکھیں';

  @override
  String get plannerUnpin => 'تبدیلی کی اجازت دیں';

  @override
  String get plannerDone => 'مکمل کریں';

  @override
  String get plannerSkip => 'چھوڑیں';

  @override
  String get plannerBegin => 'شروع کریں';

  @override
  String get plannerReopen => 'دوبارہ منصوبے میں';

  @override
  String get plannerRemove => 'ہٹائیں';

  @override
  String plannerNotScheduled(String titles) {
    return 'شامل نہ ہو سکا: $titles';
  }

  @override
  String get reasonExamSoon => 'تجویز اس لیے کہ امتحان قریب ہے۔';

  @override
  String get reasonCardsDue => 'تجویز اس لیے کہ فلیش کارڈز واجب ہیں۔';

  @override
  String get reasonTopicPending => 'تجویز اس لیے کہ یہ موضوع مکمل نہیں۔';

  @override
  String get reasonWorkoutGoal => 'تجویز آپ کی ورزش کے دورانیے کے مطابق۔';

  @override
  String get statusDone => 'مکمل';

  @override
  String get statusSkipped => 'چھوڑا گیا';

  @override
  String get calendarComplete => 'تمام اہداف پورے';

  @override
  String get calendarPartial => 'جزوی';

  @override
  String get calendarMissed => 'رہ گیا';

  @override
  String get calendarUnrecorded => 'کچھ درج نہیں';

  @override
  String get calendarLegend =>
      'مکمل = تمام اہداف پورے۔ جزوی = کچھ کیا گیا۔ رہ گیا = صرف رہ جانے والی نمازیں درج۔ خالی = کچھ درج نہیں، جو رہ جانے کے برابر نہیں۔';

  @override
  String dayDetailPrayers(int done) {
    return 'ادا شدہ نمازیں: 5 میں سے $done';
  }

  @override
  String dayDetailStudy(int minutes) {
    return 'مطالعہ: $minutes منٹ';
  }

  @override
  String dayDetailWorkouts(int count) {
    return 'ورزشیں: $count';
  }

  @override
  String dayDetailWater(int ml) {
    return 'پانی: $ml ملی لیٹر';
  }

  @override
  String get journalToday => 'آج کا غور و فکر';

  @override
  String get journalPromptWell => 'آج کیا اچھا رہا؟';

  @override
  String get journalPromptLearned => 'میں نے کیا سیکھا؟';

  @override
  String get journalPromptImprove => 'کل میں کیا بہتر کروں گا؟';

  @override
  String get journalPromptGrateful => 'میں کس چیز کا شکر گزار ہوں؟';

  @override
  String get journalPrivate =>
      'نجی۔ صرف اسی آلے پر محفوظ اور کلاؤڈ یا اے آئی سروسز کے ساتھ کبھی شیئر نہیں ہوتا۔';

  @override
  String get journalSearch => 'اندراجات تلاش کریں';

  @override
  String get journalNoEntries => 'ابھی کوئی اندراج نہیں۔';

  @override
  String get journalSaved => 'محفوظ ہو گیا';

  @override
  String get journalDeleteTitle => 'یہ اندراج حذف کریں؟';

  @override
  String get journalDeleteBody => 'یہ اندراج اس آلے سے مستقل طور پر ہٹا دے گا۔';

  @override
  String get journalEdit => 'ترمیم';

  @override
  String progressLevel(int level) {
    return 'درجہ $level';
  }

  @override
  String progressXp(int xp) {
    return '$xp ایکس پی';
  }

  @override
  String get progressXpNote =>
      'ایکس پی: ہر توجہ سیشن کے 10، ہر ورزش کے 20، اور ادا شدہ درج ہر نماز کے 5۔ ہر 200 ایکس پی پر درجہ بڑھتا ہے۔ یہ صرف حوصلہ افزائی کا شمار ہے۔';

  @override
  String get badges => 'سنگ میل';

  @override
  String get badgeEarned => 'حاصل';

  @override
  String get badgePrayerStreak7 => 'سات دن نماز کے اندراج کا سلسلہ';

  @override
  String get badgeFocus10 => 'دس توجہ سیشن';

  @override
  String get badgeStudy20h => 'اس مہینے بیس گھنٹے مطالعہ';

  @override
  String get badgeWorkouts10 => 'دس ورزشیں';

  @override
  String get badgeHydrationWeek => 'ایک ہفتہ پانی کا ہدف پورا';

  @override
  String get weeklyReport => 'پچھلے 7 دن';

  @override
  String reportBestDay(String day) {
    return 'سب سے مستقل دن: $day';
  }

  @override
  String get reportNoBestDay => 'اس ہفتے ابھی کوئی سرگرمی درج نہیں۔';

  @override
  String reportStudy(int minutes) {
    return 'مطالعہ: $minutes منٹ';
  }

  @override
  String reportWorkouts(int count) {
    return 'ورزشیں: $count';
  }

  @override
  String reportPrayers(int done, int recorded) {
    return 'ادا شدہ درج نمازیں: $recorded درج میں سے $done';
  }

  @override
  String reportWater(int days) {
    return 'پانی کا ہدف 7 میں سے $days دن پورا';
  }

  @override
  String reportSuggestion(String text) {
    return 'اگلا ہفتہ: $text';
  }

  @override
  String get suggestWater =>
      'ہر نماز یا مطالعے کے وقفے کے ساتھ ایک گلاس پانی پینے کی کوشش کریں۔';

  @override
  String get suggestStudy => 'ہر روز ایک ہی وقت پر ایک مختصر توجہ سیشن رکھیں۔';

  @override
  String get suggestWorkout =>
      'لائبریری سے ایک مختصر ورزش چنیں اور ایک دن مقرر کریں۔';

  @override
  String get suggestPrayerTracking =>
      'نمازیں ادا کرتے ہی درج کریں تاکہ آپ کی تاریخ مکمل رہے۔';

  @override
  String get suggestKeepGoing =>
      'اپنی موجودہ رفتار برقرار رکھیں۔ چھوٹے مستقل قدم اہم ہیں۔';

  @override
  String get cloudTitle => 'کلاؤڈ سنک (اختیاری)';

  @override
  String get cloudNotConfigured =>
      'اس ورژن میں کلاؤڈ سنک ترتیب نہیں دیا گیا۔ اس کے بغیر سب کچھ اس آلے پر کام کرتا ہے۔';

  @override
  String get cloudIntro =>
      'سنک آپ کے منتخب کردہ ڈیٹا کو آپ کے اپنے اکاؤنٹ میں نقل کرتا ہے تاکہ آپ ایک سے زیادہ آلات پر نووورا استعمال کر سکیں۔ یہ آپ کے آن کرنے تک بند رہتا ہے۔';

  @override
  String get cloudEmail => 'ای میل';

  @override
  String get cloudPassword => 'پاس ورڈ';

  @override
  String get cloudEmailInvalid => 'درست ای میل درج کریں';

  @override
  String get cloudPasswordShort => 'کم از کم 8 حروف استعمال کریں';

  @override
  String get cloudSignIn => 'سائن ان';

  @override
  String get cloudCreate => 'اکاؤنٹ بنائیں';

  @override
  String get cloudForgot => 'پاس ورڈ بھول گئے؟';

  @override
  String get cloudResetSent =>
      'اگر اس ای میل کا اکاؤنٹ موجود ہے تو ری سیٹ لنک بھیج دیا گیا ہے۔';

  @override
  String get cloudVerify =>
      'اپنا اکاؤنٹ تصدیق کرنے کے لیے ای میل دیکھیں، پھر سائن ان کریں۔';

  @override
  String cloudSignedInAs(String email) {
    return '$email کے طور پر سائن ان';
  }

  @override
  String get cloudSyncEnable => 'اس پروفائل کو سنک کریں';

  @override
  String get cloudCatPrayer => 'نماز کا اندراج (بطور ڈیفالٹ نجی)';

  @override
  String get cloudCatStudy => 'مطالعے کا ڈیٹا';

  @override
  String get cloudCatFitness => 'فٹنس کا ڈیٹا';

  @override
  String get cloudCatJournal => 'جرنل کے اندراجات (نجی)';

  @override
  String get cloudCatNote =>
      'سنک آن ہونے پر ترجیحات، منصوبے اور سنگ میل ہمیشہ شامل ہوتے ہیں۔ کبھی سنک نہیں ہوتے: آپ کا نام، بازیابی کا سوال، اطلاعات کی ترتیبات اور رضامندی کے انتخابات۔ ڈیٹا آپ کے اکاؤنٹ میں HTTPS کے ذریعے جاتا ہے؛ یہ اینڈ ٹو اینڈ انکرپٹڈ نہیں ہے۔';

  @override
  String get cloudSyncNow => 'ابھی سنک کریں';

  @override
  String get cloudSyncing => 'سنک ہو رہا ہے...';

  @override
  String cloudLastSync(String time) {
    return 'آخری سنک: $time';
  }

  @override
  String get cloudNeverSynced => 'ابھی سنک نہیں ہوا';

  @override
  String cloudSyncFailed(String reason) {
    return 'آخری کوشش ناکام: $reason';
  }

  @override
  String get cloudSyncDone => 'سنک مکمل';

  @override
  String cloudPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تبدیلیاں سنک کی منتظر',
      one: '1 تبدیلی سنک کی منتظر',
    );
    return '$_temp0';
  }

  @override
  String get errOffline => 'کوئی کنکشن نہیں۔ آپ کا ڈیٹا اس آلے پر محفوظ ہے۔';

  @override
  String get errUnauthorized => 'براہ کرم دوبارہ سائن ان کریں۔';

  @override
  String get errServer => 'سرور میں مسئلہ آیا۔ بعد میں کوشش کریں۔';

  @override
  String get errInvalidCredentials => 'ای میل یا پاس ورڈ درست نہیں۔';

  @override
  String get errEmailNotVerified => 'پہلے اپنی ای میل کی تصدیق کریں۔';

  @override
  String get errWeakPassword => 'یہ پاس ورڈ بہت کمزور ہے۔';

  @override
  String get errEmailTaken => 'اس ای میل کا اکاؤنٹ پہلے سے موجود ہے۔';

  @override
  String get errRateLimited => 'بہت زیادہ کوششیں۔ ذرا انتظار کریں۔';

  @override
  String get errNotConfigured => 'اس ورژن میں کلاؤڈ سنک ترتیب نہیں دیا گیا۔';

  @override
  String get errDisabled => 'سنک بند ہے۔';

  @override
  String get cloudSignOut => 'سائن آؤٹ';

  @override
  String get cloudSignOutNote =>
      'سائن آؤٹ کرنے سے تمام ڈیٹا اس آلے پر رہتا ہے۔';

  @override
  String get cloudDelete => 'کلاؤڈ اکاؤنٹ حذف کریں';

  @override
  String get cloudDeleteBody =>
      'یہ آپ کا کلاؤڈ اکاؤنٹ اور سرور پر ہر سنک شدہ ریکارڈ مستقل طور پر حذف کر دے گا۔ اس آلے کا ڈیٹا برقرار رہے گا۔';

  @override
  String get cloudDeleted => 'کلاؤڈ اکاؤنٹ حذف ہو گیا۔';

  @override
  String get backupTitle => 'بیک اپ';

  @override
  String get backupExport => 'بیک اپ برآمد کریں';

  @override
  String get backupRestore => 'بیک اپ سے بحال کریں';

  @override
  String get backupNote =>
      'بیک اپ اس پروفائل کے ڈیٹا کی JSON فائل ہے۔ اس میں آپ کا بازیابی کا سوال، پاس ورڈ یا ٹوکن شامل نہیں۔ فائل انکرپٹڈ نہیں، اسے نجی جگہ رکھیں۔';

  @override
  String get backupShareText => 'نووورا بیک اپ';

  @override
  String backupPreview(String name, int rows) {
    return '$name کا بیک اپ: $rows ریکارڈ';
  }

  @override
  String get backupAsNew => 'نئے پروفائل کے طور پر بحال کریں';

  @override
  String get backupAsNewNote => 'محفوظ: آپ کا موجودہ ڈیٹا نہیں بدلتا۔';

  @override
  String get backupReplace => 'اس پروفائل کا ڈیٹا بدل دیں';

  @override
  String get backupReplaceWarn =>
      'یہ موجودہ پروفائل کی ہر چیز کو بیک اپ سے مستقل طور پر بدل دے گا۔ اسے واپس نہیں کیا جا سکتا۔';

  @override
  String get backupDone => 'بیک اپ بحال ہو گیا۔';

  @override
  String get backupErrFormat => 'یہ درست نووورا بیک اپ نہیں ہے۔';

  @override
  String get backupErrNewer => 'یہ بیک اپ نووورا کے نئے ورژن نے بنایا ہے۔';

  @override
  String get backupErrLarge => 'یہ فائل بہت بڑی ہے۔';

  @override
  String get backupErrGeneric => 'بیک اپ بحال نہ ہو سکا۔ کچھ نہیں بدلا۔';

  @override
  String get privacyEncryption =>
      'انکرپشن: کلاؤڈ ٹریفک HTTPS استعمال کرتی ہے۔ اس آلے کا ڈیٹا اینڈرائیڈ کے ایپ سینڈ باکس اور ڈیوائس انکرپشن پر انحصار کرتا ہے؛ نووورا ابھی اپنی ڈیٹا بیس انکرپشن شامل نہیں کرتا۔';

  @override
  String get aiTitle => 'اے آئی معاون (اختیاری)';

  @override
  String get aiLabel => 'اے آئی سے تیار کردہ';

  @override
  String get aiDisclaimer =>
      'اے آئی غلطی کر سکتا ہے۔ یہ ڈاکٹر، معالج، ہنگامی خدمت یا دینی مرجع نہیں۔ طبی یا دینی سوالات کے لیے مستند ماہر یا عالم سے پوچھیں۔ یہ قرآنی متن نہ لکھتا ہے نہ بدلتا ہے۔';

  @override
  String get aiConsentTitle => 'اے آئی معاون استعمال کریں؟';

  @override
  String get aiConsentBody =>
      'جب آپ مدد مانگتے ہیں تو نیچے آپ کا منتخب کردہ ڈیٹا HTTPS کے ذریعے نووورا کے سرور کو جاتا ہے، جو جواب لکھنے کے لیے اسے اے آئی فراہم کنندہ کو بھیجتا ہے۔ آپ کا جرنل اور نام کبھی نہیں بھیجے جاتے۔ روزانہ درخواستوں کی حد ہے۔ آپ اسے کسی بھی وقت بند کر سکتے ہیں۔';

  @override
  String get aiShareStudy => 'میرا مطالعے کا خلاصہ شیئر کریں (مضمون وار منٹ)';

  @override
  String get aiShareFitness =>
      'میری فٹنس کا خلاصہ شیئر کریں (ورزشیں اور پانی کے دن)';

  @override
  String get aiSharePrayer => 'میری نماز کے اندراج کی گنتی شیئر کریں';

  @override
  String get aiEnable => 'اے آئی معاون آن کریں';

  @override
  String get aiNeedsCloud =>
      'اے آئی معاون کے لیے کلاؤڈ اکاؤنٹ اور ترتیب شدہ سرور درکار ہے۔ آپ نیچے آف لائن تجویز استعمال کر سکتے ہیں۔';

  @override
  String get aiOfflineTitle => 'آف لائن تجویز';

  @override
  String get aiCoachButton => 'اگلے ہفتے کے اہداف تجویز کریں';

  @override
  String get aiToolsTitle => 'مطالعے کے اوزار';

  @override
  String get aiNotesLabel => 'آپ کے نوٹس';

  @override
  String get aiNotesWarn =>
      'یہاں درج متن صرف تب اے آئی سروس کو بھیجا جاتا ہے جب آپ نیچے کا کوئی بٹن دبائیں۔';

  @override
  String get aiDraftCards => 'فلیش کارڈز کا مسودہ';

  @override
  String get aiSummarize => 'خلاصہ';

  @override
  String get aiQuestions => 'مشقی سوالات';

  @override
  String get aiExplain => 'وضاحت';

  @override
  String get aiReviewCards =>
      'مسودے دیکھیں۔ محفوظ کرنے سے پہلے کسی بھی کارڈ میں ترمیم کریں یا نشان ہٹائیں۔';

  @override
  String aiSaveCards(int count) {
    return 'منتخب کارڈز محفوظ کریں ($count)';
  }

  @override
  String get aiCardsSaved => 'کارڈز محفوظ ہو گئے';

  @override
  String get aiHistory => 'گفتگو کی تاریخ';

  @override
  String get aiHistoryEmpty => 'کوئی تاریخ نہیں۔';

  @override
  String get aiClearHistory => 'تاریخ صاف کریں';

  @override
  String get aiHistoryCleared => 'تاریخ صاف ہو گئی';

  @override
  String get aiThinking => 'سوچ رہا ہے...';

  @override
  String get aiErrConsent => 'پہلے اے آئی معاون آن کریں۔';

  @override
  String get aiErrTooSoon =>
      'براہ کرم درخواستوں کے درمیان چند سیکنڈ انتظار کریں۔';

  @override
  String get aiErrRateLimited =>
      'روزانہ اے آئی کی حد پوری ہو گئی۔ کل دوبارہ کوشش کریں۔';

  @override
  String get aiErrTooLong => 'یہ متن بہت لمبا ہے۔';

  @override
  String get aiErrInvalid =>
      'اے آئی کا جواب قابل استعمال نہیں تھا۔ کچھ محفوظ نہیں ہوا۔';

  @override
  String get aiErrEmpty => 'پہلے کچھ نوٹس درج کریں۔';

  @override
  String get notifGenericBody => 'آپ کے لیے ایک یاددہانی ہے۔';

  @override
  String notifPrayerBody(String prayer) {
    return '$prayer کا وقت ہو گیا ہے۔';
  }

  @override
  String get notifStudyBody => 'توجہ سیشن کا وقت۔';

  @override
  String get notifWorkoutBody => 'حرکت کرنے کا وقت۔';

  @override
  String get notifHydrationBody => 'ایک گلاس پانی؟';

  @override
  String get notifReflectionBody => 'اپنے دن پر غور کرنے کا لمحہ۔';

  @override
  String get notifFlashcardsBody => 'فلیش کارڈز دہرانے کے لیے تیار ہیں۔';

  @override
  String get notifWeeklyBody => 'آپ کا ہفتہ وار خلاصہ تیار ہے۔';

  @override
  String get notifTitle => 'یاددہانیاں';

  @override
  String get notifWhyTitle => 'یاددہانیوں کی اجازت دیں؟';

  @override
  String get notifWhyBody =>
      'نووورا آپ کو نماز کے اوقات، مطالعے کے سیشن، ورزش، پانی، غور و فکر اور ہفتہ وار خلاصے کی یاد دلا سکتا ہے۔ یاددہانیاں اسی آلے پر طے ہوتی ہیں اور آف لائن کام کرتی ہیں۔ ہر ایک آپ خود چنتے ہیں، اور سب بند بھی کر سکتے ہیں۔';

  @override
  String get notifAllow => 'اطلاعات کی اجازت دیں';

  @override
  String get notifDeniedBody =>
      'نووورا کے لیے اطلاعات بند ہیں۔ یاددہانیاں پانے کے لیے فون کی ایپ ترتیبات میں انہیں آن کریں۔';

  @override
  String get notifSaved => 'یاددہانیاں اپڈیٹ ہو گئیں';

  @override
  String get notifPrayer => 'نماز کے اوقات';

  @override
  String get notifPrayerNeedsLocation =>
      'پہلے نماز کا مقام مقرر کریں تاکہ اوقات شمار ہو سکیں۔';

  @override
  String notifOffset(int minutes) {
    return '$minutes منٹ پہلے یاد دلائیں';
  }

  @override
  String get notifAtTime => 'نماز کے وقت پر یاد دلائیں';

  @override
  String get notifStudy => 'مطالعے کا سیشن';

  @override
  String get notifWorkout => 'ورزش';

  @override
  String notifHydration(int hours) {
    return 'پانی (ہر $hours گھنٹے، صرف دن میں)';
  }

  @override
  String get notifReflection => 'روزانہ غور و فکر';

  @override
  String get notifFlashcards => 'فلیش کارڈ کا جائزہ (صرف جب کارڈ واجب ہوں)';

  @override
  String get notifWeekly => 'ہفتہ وار خلاصہ';

  @override
  String get notifQuiet => 'خاموش اوقات';

  @override
  String get notifQuietNote =>
      'خاموش اوقات نماز کے علاوہ ہر یاددہانی کو خاموش کرتے ہیں، جو آپ نے الگ الگ چنی ہیں۔';

  @override
  String get notifQuietOff => 'بند';

  @override
  String notifQuietRange(String start, String end) {
    return '$start سے $end';
  }

  @override
  String get notifDetails => 'اطلاعات میں تفصیل دکھائیں';

  @override
  String get notifDetailsNote =>
      'بطور ڈیفالٹ بند: اطلاعات صرف یہ بتاتی ہیں کہ آپ کے لیے یاددہانی ہے، تاکہ لاک اسکرین پر کوئی ذاتی چیز نہ آئے۔';

  @override
  String get notifExactNote =>
      'یاددہانیاں چند منٹ دیر سے آ سکتی ہیں جب تک آپ کا فون نووورا کو درست الارم کی اجازت نہ دے۔';

  @override
  String get notifDay => 'ہفتے کا دن';

  @override
  String get notifTime => 'وقت';

  @override
  String get weekdayMon => 'پیر';

  @override
  String get weekdayTue => 'منگل';

  @override
  String get weekdayWed => 'بدھ';

  @override
  String get weekdayThu => 'جمعرات';

  @override
  String get weekdayFri => 'جمعہ';

  @override
  String get weekdaySat => 'ہفتہ';

  @override
  String get weekdaySun => 'اتوار';
}
