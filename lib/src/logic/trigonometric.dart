import 'dart:math';

class Trigonometric {
  // Trigonometric Functions

  // degree sin
  static double dsin(double d) => sin(dtr(d));

  // degree cos
  static double dcos(double d) => cos(dtr(d));

  // degree tan
  static double dtan(double d) => tan(dtr(d));

  // degree arcsin
  static double darcsin(double x) => rtd(asin(x));

  // degree arccos
  static double darccos(double x) => rtd(acos(x));

  // degree arctan
  static double darctan(double x) => rtd(atan(x));

  // degree arctan2
  static double darctan2(double y, double x) => rtd(atan2(y, x));

  // degree arccot
  static double darccot(double x) => rtd(atan(1 / x));

  // degree to radian
  static double dtr(double degree) => (degree * pi) / 180.0;

  // radian to degree
  static double rtd(double radian) => (radian * 180.0) / pi;

  // range reduce angle in degrees.
  static double fixangle(double angle) {
    angle = angle - 360.0 * (angle / 360.0).floor();
    angle = angle < 0 ? angle + 360.0 : angle;
    return angle;
  }

  // range reduce hours to 0..23
  static double fixhour(double hours) {
    hours = hours - 24.0 * (hours / 24.0).floor();
    return hours < 0 ? hours + 24.0 : hours;
  }
}