import '../enums/isha_selector.dart';
import '../enums/maghrib_selector.dart';

class CalculationMethod {
  final double fajrAngle;
  final MaghribCalculation maghribCalculation;
  final IshaCalculation ishaCalculation;

  const CalculationMethod(
      {required this.fajrAngle,
        required this.maghribCalculation,
        required this.ishaCalculation});

  CalculationMethod copyWith({
    double? fajrAngle,
    MaghribCalculation? maghribCalculation,
    IshaCalculation? ishaCalculation,
  }) {
    return CalculationMethod(
      fajrAngle: fajrAngle ?? this.fajrAngle,
      maghribCalculation: this.maghribCalculation.copyWith(
          selector: maghribCalculation?.selector,
          value: maghribCalculation?.value),
      ishaCalculation: this.ishaCalculation.copyWith(
          selector: ishaCalculation?.selector, value: ishaCalculation?.value),
    );
  }

  static CalculationMethod jafari() => const CalculationMethod(
    fajrAngle: 16,
    maghribCalculation:
    MaghribCalculation(selector: MaghribSelector.angle, value: 4),
    ishaCalculation:
    IshaCalculation(selector: IshaSelector.angle, value: 14),
  );

  static CalculationMethod karachi() => const CalculationMethod(
    fajrAngle: 18,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 0),
    ishaCalculation:
    IshaCalculation(selector: IshaSelector.angle, value: 18),
  );

  static CalculationMethod isna() => const CalculationMethod(
    fajrAngle: 15,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 0),
    ishaCalculation: IshaCalculation(
        selector: IshaSelector.angle, value: 15),
  );

  static CalculationMethod mwl() => const CalculationMethod(
    fajrAngle: 18,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 0),
    ishaCalculation: IshaCalculation(
        selector: IshaSelector.angle, value: 17),
  );

  static CalculationMethod makkah() => const CalculationMethod(
    fajrAngle: 18.5,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 0),
    ishaCalculation: IshaCalculation(
        selector: IshaSelector.minutesAfterMaghrib, value: 90),
  );

  static CalculationMethod egypt() => const CalculationMethod(
    fajrAngle: 19.5,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 0),
    ishaCalculation: IshaCalculation(
        selector: IshaSelector.angle, value: 17.5),
  );

  static CalculationMethod tehran() => const CalculationMethod(
    fajrAngle: 17.7,
    maghribCalculation:
    MaghribCalculation(selector: MaghribSelector.angle, value: 4.5),
    ishaCalculation:
    IshaCalculation(selector: IshaSelector.angle, value: 14),
  );

  static CalculationMethod custom() => const CalculationMethod(
    fajrAngle: 12,
    maghribCalculation: MaghribCalculation(
        selector: MaghribSelector.minutesAfterSunset, value: 5),
    ishaCalculation: IshaCalculation(
        selector: IshaSelector.minutesAfterMaghrib, value: 90),
  );
}

class MaghribCalculation {
  final MaghribSelector selector;
  final double value;

  const MaghribCalculation({required this.selector, required this.value});

  MaghribCalculation copyWith({
    double? value,
    MaghribSelector? selector,
  }) =>
      MaghribCalculation(
        value: value ?? this.value,
        selector: selector ?? this.selector,
      );
}

class IshaCalculation {
  final IshaSelector selector;
  final double value;

  const IshaCalculation({required this.selector, required this.value});

  IshaCalculation copyWith({
    double? value,
    IshaSelector? selector,
  }) =>
      IshaCalculation(
        value: value ?? this.value,
        selector: selector ?? this.selector,
      );
}
