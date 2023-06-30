import '../enums/higher_latitudes_adjusting.dart';

class Portion {
  // The night portion used for adjusting times in higher latitudes
  static double night(
      {required double angle,
      required HigherLatitudesAdjusting adjustHighLats}) {
    if (adjustHighLats == HigherLatitudesAdjusting.angleBased) {
      return 1 / 60 * angle;
    }
    if (adjustHighLats == HigherLatitudesAdjusting.midnight) {
      return 1 / 2;
    }
    if (adjustHighLats == HigherLatitudesAdjusting.oneSeventh) {
      return 1 / 7;
    }
    return double.nan;
  }

// Convert hours to day portions
  static List<double> day(List<double> times) {
    for (int i = 0; i < 7; i++) {
      times[i] /= 24;
    }
    return times;
  }
}
