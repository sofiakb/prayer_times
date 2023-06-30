//---------------------- Misc Functions -----------------------
import '../logic/trigonometric.dart';
import 'constants.dart';

double timeDiff(double time1, double time2) =>
    Trigonometric.fixhour(time2 - time1);

String twoDigitsFormat(int num) => (num < 10) ? '0$num' : num.toString();

// Convert float hours to 24h format
String floatToTime24(double time) {
  if (time.isNaN) return invalidTime;
  time = Trigonometric.fixhour(time + 0.5 / 60); // add 0.5 minutes to round
  int hours = time.floor();
  int minutes = ((time - hours) * 60).floor();
  return '${twoDigitsFormat(hours)}:${twoDigitsFormat(minutes)}';
}

// Convert float hours to 12h format
String floatToTime12(double time,
    {bool noSuffix = false}) {
  if (time.isNaN) return invalidTime;
  time = Trigonometric.fixhour(time + 0.5 / 60); // add 0.5 minutes to round
  int hours = time.floor();
  int minutes = ((time - hours) * 60).floor();
  String suffix = hours >= 12 ? ' pm' : ' am';
  hours = (hours + 12 - 1) % 12 + 1;
  return '$hours:${twoDigitsFormat(minutes)}${noSuffix ? '' : suffix}';
}

//---------------------- Julian Date Functions -----------------------
double julianDate(int year, int month, int day) {
  if (month <= 2) {
    year -= 1;
    month += 12;
  }
  int A = (year / 100).floor();
  int B = 2 - A + (A / 4).floor();

  double julianDate = (365.25 * (year + 4716)).floorToDouble() +
      (30.6001 * (month + 1)).floorToDouble() +
      day +
      B -
      1524.5;
  return julianDate;
}