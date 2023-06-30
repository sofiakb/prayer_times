import 'enums/prayer.dart';
import 'logic/calculator_params.dart';
import 'prayer_times_calculator.dart';

class PrayerTimes {
  late DateTime fajrAfter;
  late DateTime fajr;
  late DateTime shuruq;
  late DateTime sunset;
  late DateTime dhuhr;
  late DateTime asr;
  late DateTime maghrib;
  late DateTime isha;
  late DateTime ishaBefore;

  late CalculatorParams params;

  Map<String, DateTime> toJson() => {
        'ishaBefore': ishaBefore,
        'fajr': fajr,
        'shuruq': shuruq,
        'sunset': sunset,
        'dhuhr': dhuhr,
        'asr': asr,
        'maghrib': maghrib,
        'isha': isha,
        'fajrAfter': fajrAfter
      };

  PrayerTimes({
    required this.params,
  }) {
    Map<String, DateTime> result =
        PrayerTimesCalculator(params: params).getPrayerTimes();

    fajr = result['fajr']!;
    shuruq = result['shuruq']!;
    sunset = result['sunset']!;
    dhuhr = result['dhuhr']!;
    asr = result['asr']!;
    maghrib = result['maghrib']!;
    isha = result['isha']!;
    ishaBefore = result['ishaBefore']!;
    fajrAfter = result['fajrAfter']!;
  }

  DateTime? timeForPrayer(String prayer) {
    if (prayer == Prayer.fajr) {
      return fajr;
    } else if (prayer == Prayer.shuruq) {
      return shuruq;
    } else if (prayer == Prayer.dhuhr) {
      return dhuhr;
    } else if (prayer == Prayer.asr) {
      return asr;
    } else if (prayer == Prayer.maghrib) {
      return maghrib;
    } else if (prayer == Prayer.isha) {
      return isha;
    } else if (prayer == Prayer.ishaBefore) {
      return ishaBefore;
    } else if (prayer == Prayer.fajrAfter) {
      return fajrAfter;
    } else {
      return null;
    }
  }

  currentPrayer({required DateTime date}) {
    // if (date == null) {
    //   date = DateTime.now();
    // }
    if (date.isAfter(isha)) {
      return Prayer.isha;
    } else if (date.isAfter(maghrib)) {
      return Prayer.maghrib;
    } else if (date.isAfter(asr)) {
      return Prayer.asr;
    } else if (date.isAfter(dhuhr)) {
      return Prayer.dhuhr;
    } else if (date.isAfter(shuruq)) {
      return Prayer.shuruq;
    } else if (date.isAfter(fajr)) {
      return Prayer.fajr;
    } else {
      return Prayer.ishaBefore;
    }
  }

  nextPrayer({DateTime? date}) {
    date ??= DateTime.now();
    if (date.isAfter(isha)) {
      return Prayer.fajrAfter;
    } else if (date.isAfter(maghrib)) {
      return Prayer.isha;
    } else if (date.isAfter(asr)) {
      return Prayer.maghrib;
    } else if (date.isAfter(dhuhr)) {
      return Prayer.asr;
    } else if (date.isAfter(shuruq)) {
      return Prayer.dhuhr;
    } else if (date.isAfter(fajr)) {
      return Prayer.shuruq;
    } else {
      return Prayer.fajr;
    }
  }
}
