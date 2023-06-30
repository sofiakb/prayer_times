import 'package:prayer_times/prayer_times.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final prayerTimes = PrayerTimes(
        params: CalculatorParams(
            coordinates: Coordinates(
              latitude: 50.3555,
              longitude: 3.11127,
            ),
            calculationMethod: CalculationMethod.mwl(),
            adjustHighLats: HigherLatitudesAdjusting.angleBased,
            asrJuristic: AsrJuristic.shafi,
            dhuhrMinutes: 0,
            numIterations: 1,
            timeFormat: TimeFormats.time24,
            date: DateTime(2023, 6, 30, 12, 0, 0).toLocal()));

    setUp(() {
      // Additional setup goes here.
    });

    test('ishaBefore test', () => expect(prayerTimes.ishaBefore.microsecondsSinceEpoch, 1688076720000000));

    test('fajr test', () => expect(prayerTimes.fajr.microsecondsSinceEpoch, 1688088180000000));

    test('shuruq test', () => expect(prayerTimes.shuruq.microsecondsSinceEpoch, 1688096400000000));

    test('sunset test', () => expect(prayerTimes.sunset.microsecondsSinceEpoch, 1688155320000000));

    test('dhuhr test', () => expect(prayerTimes.dhuhr.microsecondsSinceEpoch, 1688125860000000));

    test('asr test', () => expect(prayerTimes.asr.microsecondsSinceEpoch, 1688141460000000));

    test('maghrib test', () => expect(prayerTimes.maghrib.microsecondsSinceEpoch, 1688155320000000));

    test('isha test', () => expect(prayerTimes.isha.microsecondsSinceEpoch, 1688163120000000));

    test('fajrAfter test', () => expect(prayerTimes.fajrAfter.microsecondsSinceEpoch, 1688174580000000));
  });
}
