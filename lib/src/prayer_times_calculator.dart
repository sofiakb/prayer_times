import 'enums/asr_juristic.dart';
import 'enums/higher_latitudes_adjusting.dart';
import 'enums/isha_selector.dart';
import 'enums/maghrib_selector.dart';
import 'enums/time_formats.dart';
import 'logic/calculation.dart';
import 'logic/calculation_method.dart';
import 'logic/calculator_params.dart';
import 'logic/coordinates.dart';
import 'logic/portion.dart';
import 'logic/trigonometric.dart';
import 'utils/constants.dart';
import 'utils/utils.dart';

class PrayerTimesCalculator {
  // Time Names
  final List<String> timeNames = [
    "Fajr",
    "Shuruq",
    "Dhuhr",
    "Asr",
    "Sunset",
    "Maghrib",
    "Isha",
    "IshaBefore",
    "FajrAfter",
  ];

  // Global Variables
  int asrJuristic = AsrJuristic.shafi; // Juristic method for Asr
  int dhuhrMinutes = 0; // minutes after mid-day for Dhuhr

  late CalculatorParams params;
  late Coordinates coordinates;
  late DateTime date;
  bool loop = true;

  late double _julianDate; // Julian date

  // Technical Settings
  final int numIterations = 3; // number of iterations needed to compute times
  final int timeZone = 0; // time-zone

  // adjusting method for higher latitudes
  HigherLatitudesAdjusting adjustHighLats = HigherLatitudesAdjusting.angleBased;

  // time format
  TimeFormats timeFormat = TimeFormats.time24;

  CalculationMethod calculationMethod = CalculationMethod.mwl();
  CalculationMethod customCalculationMethod = CalculationMethod.custom();

  PrayerTimesCalculator({required this.params, this.loop = true}) {
    coordinates = params.coordinates;
    date = params.date;
    calculationMethod = params.calculationMethod ?? calculationMethod;
    asrJuristic = params.asrJuristic ?? asrJuristic;
    dhuhrMinutes = params.dhuhrMinutes ?? dhuhrMinutes;
    timeFormat = params.timeFormat ?? timeFormat;

    prayTime(calculationMethod);
  }

  prayTime(CalculationMethod calculationMethod) {
    setCalcMethod(calculationMethod);
  }

  //-------------------- Interface Functions --------------------

  // set the calculation method
  void setCalcMethod(CalculationMethod calculationMethod) =>
      this.calculationMethod = calculationMethod;

  // return prayer times for a given date
  Map<String, DateTime> getDatePrayerTimes(Coordinates coordinates) {
    this.coordinates = coordinates;

    _julianDate = julianDate(date.year, date.month, date.day) -
        coordinates.longitude / (15 * 24);

    List<String> daysTmp = _computeDayTimes().map((e) => e.toString()).toList();

    Map<String, DateTime> days = {};

    for (int i = 0; i < daysTmp.length; i++) {
      String d = daysTmp[i];

      if (d != invalidTime) {
        List<String> timeComponents = d.split(':');
        int hour = int.tryParse(timeComponents[0]) ?? 0;
        int minute = int.tryParse(timeComponents[1]) ?? 0;
        DateTime dateTime = date
            .toUtc()
            .copyWith(hour: hour, minute: minute, second: 0)
            .toLocal();
        dateTime = dateTime.add(Duration(hours: timeZone));
        // dateTime = dateTime.toUtc().add(Duration(hours: timeZone)).toLocal();
        // if (i != 4) {
        days[timeNames[i].toLowerCase()] = dateTime;
        // }
      }
    }

    if (loop) {
      days["fajrAfter"] = PrayerTimesCalculator(params: params.copyWith(date: date.add(Duration(days: 1))), loop: false).getPrayerTimes()['fajr']!;
      days["ishaBefore"] = PrayerTimesCalculator(params: params.copyWith(date: date.add(Duration(days: -1))), loop: false).getPrayerTimes()['isha']!;
    }

    return days;
  }

  // return prayer times for a given timestamp
  Map<String, DateTime> getPrayerTimes() {
    return getDatePrayerTimes(coordinates);
  }

  // set the juristic method for Asr
  void setAsrMethod(int methodID) =>
      asrJuristic = (methodID < 0 || methodID > 1) ? asrJuristic : methodID;

  // set the angle for calculating Fajr
  void setFajrAngle(double angle) =>
      setCustomParams(customCalculationMethod.copyWith(
        fajrAngle: angle,
      ));

  // set the angle for calculating Maghrib
  void setMaghribAngle(double angle) =>
      setCustomParams(customCalculationMethod.copyWith(
        maghribCalculation:
            MaghribCalculation(selector: MaghribSelector.angle, value: angle),
      ));

  // set the angle for calculating Isha
  void setIshaAngle(double angle) =>
      setCustomParams(customCalculationMethod.copyWith(
        ishaCalculation:
            IshaCalculation(selector: IshaSelector.angle, value: angle),
      ));

  // set the minutes after mid-day for calculating Dhuhr
  void setDhuhrMinutes(int minutes) => dhuhrMinutes = minutes;

  // set the minutes after Sunset for calculating Maghrib
  void setMaghribMinutes(int minutes) =>
      setCustomParams(customCalculationMethod.copyWith(
        maghribCalculation: MaghribCalculation(
            selector: MaghribSelector.minutesAfterSunset,
            value: minutes.toDouble()),
      ));

  // set the minutes after Maghrib for calculating Isha
  void setIshaMinutes(int minutes) =>
      setCustomParams(customCalculationMethod.copyWith(
        ishaCalculation: IshaCalculation(
            selector: IshaSelector.minutesAfterMaghrib,
            value: minutes.toDouble()),
      ));

  // set custom values for calculation parameters
  void setCustomParams(CalculationMethod params) {
    customCalculationMethod = customCalculationMethod.copyWith(
      fajrAngle: params.fajrAngle,
      maghribCalculation: params.maghribCalculation,
      ishaCalculation: params.ishaCalculation,
    );

    calculationMethod = customCalculationMethod;
  }

  //---------------------- Compute Prayer Times -----------------------

  // Compute mid-day (Dhuhr, Zawal) time
  double _computeMidDay(double t) {
    double T = Calculation.equationOfTime(_julianDate + t);
    double Z = Trigonometric.fixhour(12 - T);
    return Z;
  }

// Compute time for a given angle G
  double _computeTime(double angle, double time) {
    double D = Calculation.sunDeclination(_julianDate + time);
    double Z = _computeMidDay(time);
    double V = 1 /
        15 *
        Trigonometric.darccos((-(Trigonometric.dsin(angle)) -
                Trigonometric.dsin(D) *
                    Trigonometric.dsin(coordinates.latitude)) /
            (Trigonometric.dcos(D) * Trigonometric.dcos(coordinates.latitude)));
    double result = Z + (angle > 90 ? -V : V);

    return result.isNaN ? time : result;
  }

// Compute the time of Asr
  double _computeAsr(double angle, double time) {
    // Shafii: step=1, Hanafi: step=2
    double D = Calculation.sunDeclination(_julianDate + time);
    double G = -Trigonometric.darccot(
        angle + Trigonometric.dtan((coordinates.latitude - D).abs()));
    return _computeTime(G, time);
  }

// Compute prayer times at a given Julian date
  List<double> _computeTimes(List<double> times) {
    List<double> t = Portion.day(times);

    double fajr = _computeTime(180 - calculationMethod.fajrAngle, t[0]);
    double sunrise = _computeTime(180 - 0.833, t[1]);
    double dhuhr = _computeMidDay(t[2]);
    double asr = _computeAsr(1.0 + asrJuristic, t[3]);
    double sunset = _computeTime(0.833, t[4]);
    double maghrib =
        _computeTime(calculationMethod.maghribCalculation.value, t[5]);
    double isha = _computeTime(calculationMethod.ishaCalculation.value, t[6]);

    return [fajr, sunrise, dhuhr, asr, sunset, maghrib, isha];
  }

// Compute prayer times at a given Julian date
  List _computeDayTimes() {
    List<double> times = [5, 6, 12, 13, 18, 18, 20]; // Default times

    for (int i = 1; i <= numIterations; i++) {
      times = _computeTimes(times);
    }

    times = _adjustTimes(times);
    return _adjustTimesFormat(times);
  }

// Adjust times in a prayer time array
  List<double> _adjustTimes(List<double> times) {
    for (int i = 0; i < times.length; i++) {
      times[i] += timeZone - coordinates.longitude / 15;
    }
    times[2] += dhuhrMinutes / 60; // Dhuhr
    if (calculationMethod.maghribCalculation.selector ==
        MaghribSelector.minutesAfterSunset) {
      // Maghrib
      times[5] = times[4] + calculationMethod.maghribCalculation.value / 60;
    }
    if (calculationMethod.ishaCalculation.selector ==
        IshaSelector.minutesAfterMaghrib) {
      // Isha
      times[6] = times[5] + calculationMethod.ishaCalculation.value / 60;
    }

    if (adjustHighLats != HigherLatitudesAdjusting.none) {
      times = _adjustHighLatTimes(times);
    }
    return times;
  }

// Convert times array to the given time format
  List<dynamic> _adjustTimesFormat(List<double> times) {
    List<String> timeResult = times.map((t) => floatToTime24(t)).toList();

    if (timeFormat == TimeFormats.float) {
      return times;
    }
    for (int i = 0; i < times.length; i++) {
      if (timeFormat == TimeFormats.time12) {
        timeResult[i] = floatToTime12(times[i]);
      } else if (timeFormat == TimeFormats.time12NS) {
        timeResult[i] = floatToTime12(times[i], noSuffix: true);
      } else {
        timeResult[i] = floatToTime24(times[i]);
      }
    }
    return timeResult;
  }

// Adjust Fajr, Isha, and Maghrib for locations in higher latitudes
  List<double> _adjustHighLatTimes(List<double> times) {
    double nightTime = timeDiff(times[4], times[1]); // Sunset to sunrise

    // Adjust Fajr
    double fajrDiff = Portion.night(
            angle: calculationMethod.fajrAngle,
            adjustHighLats: adjustHighLats) *
        nightTime;
    if (times[0].isNaN || timeDiff(times[0], times[1]) > fajrDiff) {
      times[0] = times[1] - fajrDiff;
    }

    // Adjust Isha
    double ishaAngle =
        (calculationMethod.ishaCalculation.selector == IshaSelector.angle)
            ? calculationMethod.ishaCalculation.value
            : 18;
    double ishaDiff =
        Portion.night(angle: ishaAngle, adjustHighLats: adjustHighLats) *
            nightTime;
    if (times[6].isNaN || timeDiff(times[4], times[6]) > ishaDiff) {
      times[6] = times[4] + ishaDiff;
    }

    // Adjust Maghrib
    double maghribAngle =
        (calculationMethod.maghribCalculation.selector == MaghribSelector.angle)
            ? calculationMethod.maghribCalculation.value
            : 4;
    double maghribDiff =
        Portion.night(angle: maghribAngle, adjustHighLats: adjustHighLats) *
            nightTime;
    if (times[5].isNaN || timeDiff(times[4], times[5]) > maghribDiff) {
      times[5] = times[4] + maghribDiff;
    }

    return times;
  }
}
