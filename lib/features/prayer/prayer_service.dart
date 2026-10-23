import 'package:adhan_dart/adhan_dart.dart';

/// The five tracked prayers, in daily order.
enum PrayerName { fajr, dhuhr, asr, maghrib, isha }

class PrayerConfig {
  const PrayerConfig({
    required this.method,
    required this.asrMethod,
    required this.latitude,
    required this.longitude,
  });

  /// [CalculationMethod] enum name.
  final String method;

  /// `shafi` (standard) or `hanafi`.
  final String asrMethod;
  final double latitude;
  final double longitude;
}

class DayPrayerTimes {
  const DayPrayerTimes({
    required this.times,
    required this.sunrise,
    required this.nextFajr,
  });

  /// Device-local times for the day.
  final Map<PrayerName, DateTime> times;
  final DateTime sunrise;

  /// Fajr of the following day, so "next prayer" works after Isha.
  final DateTime nextFajr;

  /// First prayer strictly after [now], or Fajr tomorrow (as `null` prayer)
  /// once Isha has passed.
  ({PrayerName? prayer, DateTime time}) next(DateTime now) {
    for (final p in PrayerName.values) {
      if (times[p]!.isAfter(now)) return (prayer: p, time: times[p]!);
    }
    return (prayer: null, time: nextFajr);
  }

  /// The prayer whose window is currently open, or null before Fajr.
  PrayerName? current(DateTime now) {
    PrayerName? cur;
    for (final p in PrayerName.values) {
      if (!times[p]!.isAfter(now)) cur = p;
    }
    return cur;
  }
}

/// Wraps `adhan_dart`. Times are calculated, never hardcoded, and may differ
/// from local mosque timetables.
class PrayerService {
  const PrayerService();

  static const methods = <CalculationMethod>[
    CalculationMethod.muslimWorldLeague,
    CalculationMethod.karachi,
    CalculationMethod.northAmerica,
    CalculationMethod.egyptian,
    CalculationMethod.ummAlQura,
    CalculationMethod.dubai,
    CalculationMethod.qatar,
    CalculationMethod.kuwait,
    CalculationMethod.moonsightingCommittee,
    CalculationMethod.singapore,
    CalculationMethod.turkiye,
    CalculationMethod.tehran,
  ];

  CalculationParameters _params(PrayerConfig c) {
    final method = CalculationMethod.values.firstWhere(
      (m) => m.name == c.method,
      orElse: () => CalculationMethod.muslimWorldLeague,
    );
    final params = switch (method) {
      CalculationMethod.karachi => CalculationMethodParameters.karachi(),
      CalculationMethod.northAmerica =>
        CalculationMethodParameters.northAmerica(),
      CalculationMethod.egyptian => CalculationMethodParameters.egyptian(),
      CalculationMethod.ummAlQura => CalculationMethodParameters.ummAlQura(),
      CalculationMethod.dubai => CalculationMethodParameters.dubai(),
      CalculationMethod.qatar => CalculationMethodParameters.qatar(),
      CalculationMethod.kuwait => CalculationMethodParameters.kuwait(),
      CalculationMethod.moonsightingCommittee =>
        CalculationMethodParameters.moonsightingCommittee(),
      CalculationMethod.singapore => CalculationMethodParameters.singapore(),
      CalculationMethod.turkiye => CalculationMethodParameters.turkiye(),
      CalculationMethod.tehran => CalculationMethodParameters.tehran(),
      _ => CalculationMethodParameters.muslimWorldLeague(),
    };
    params.madhab = c.asrMethod == 'hanafi' ? Madhab.hanafi : Madhab.shafi;
    // Avoid absurd Fajr/Isha at high latitudes.
    params.highLatitudeRule =
        HighLatitudeRule.recommended(Coordinates(c.latitude, c.longitude));
    return params;
  }

  /// Calculates times for the calendar day of [day] (only y/m/d are used) and
  /// converts them to the device's local time zone, which also accounts for
  /// the device's daylight-saving rules on that date.
  DayPrayerTimes forDay(PrayerConfig config, DateTime day) {
    final coords = Coordinates(config.latitude, config.longitude);
    final params = _params(config);
    PrayerTimes calc(DateTime d) => PrayerTimes(
          coordinates: coords,
          date: DateTime(d.year, d.month, d.day),
          calculationParameters: params,
          precision: false,
        );
    final today = calc(day);
    final tomorrow = calc(DateTime(day.year, day.month, day.day + 1));
    return DayPrayerTimes(
      times: {
        PrayerName.fajr: today.fajr.toLocal(),
        PrayerName.dhuhr: today.dhuhr.toLocal(),
        PrayerName.asr: today.asr.toLocal(),
        PrayerName.maghrib: today.maghrib.toLocal(),
        PrayerName.isha: today.isha.toLocal(),
      },
      sunrise: today.sunrise.toLocal(),
      nextFajr: tomorrow.fajr.toLocal(),
    );
  }
}
