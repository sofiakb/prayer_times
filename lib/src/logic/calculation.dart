import 'trigonometric.dart';

class Calculation {
  // Compute declination angle of sun and equation of time
  static List<double> sunPosition(double jd) {
    double D = jd - 2451545.0;
    double g = Trigonometric.fixangle(357.529 + 0.98560028 * D);
    double q = Trigonometric.fixangle(280.459 + 0.98564736 * D);
    double L = Trigonometric.fixangle(
        q + 1.915 * Trigonometric.dsin(g) + 0.020 * Trigonometric.dsin(2 * g));

    double e = 23.439 - 0.00000036 * D;

    double d =
        Trigonometric.darcsin(Trigonometric.dsin(e) * Trigonometric.dsin(L));
    double RA = Trigonometric.darctan2(
            Trigonometric.dcos(e) * Trigonometric.dsin(L),
            Trigonometric.dcos(L)) /
        15;
    RA = Trigonometric.fixhour(RA);
    double EqT = q / 15 - RA;

    return [d, EqT];
  }

  // Compute equation of time
  static double equationOfTime(double jd) {
    List<double> sp = sunPosition(jd);
    return sp[1];
  }

// Compute declination angle of sun
  static double sunDeclination(double jd) {
    List<double> sp = sunPosition(jd);
    return sp[0];
  }
}
