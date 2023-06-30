import 'package:prayer_times/prayer_times.dart';

void main() {
  DateTime date = DateTime.now();

  PrayerTimes test = PrayerTimes(
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
          date: date));

  print(test.toJson());
}
