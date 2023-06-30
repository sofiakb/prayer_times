import '../enums/higher_latitudes_adjusting.dart';
import '../enums/time_formats.dart';
import 'calculation_method.dart';
import 'coordinates.dart';

class CalculatorParams {
  // Global Variables
  int? asrJuristic; // Juristic method for Asr
  int? dhuhrMinutes; // minutes after mid-day for Dhuhr

  final Coordinates coordinates;
  final DateTime date;

  // Technical Settings
  int? numIterations; // number of iterations needed to compute times

  // adjusting method for higher latitudes
  HigherLatitudesAdjusting? adjustHighLats;

  // time format
  TimeFormats? timeFormat;

  CalculationMethod? calculationMethod;

  CalculatorParams({
    required this.coordinates,
    required this.date,
    this.asrJuristic,
    this.dhuhrMinutes = 0,
    this.numIterations,
    this.adjustHighLats,
    this.timeFormat,
    this.calculationMethod,
  });

  CalculatorParams copyWith({
    int? asrJuristic,
    int? dhuhrMinutes,
    Coordinates? coordinates,
    DateTime? date,
    int? numIterations,
    HigherLatitudesAdjusting? adjustHighLats,
    TimeFormats? timeFormat,
    CalculationMethod? calculationMethod,
  }) {
    return CalculatorParams(
      coordinates: coordinates ?? this.coordinates,
      date: date ?? this.date,
      asrJuristic: asrJuristic ?? this.asrJuristic,
      dhuhrMinutes: dhuhrMinutes ?? this.dhuhrMinutes,
      numIterations: numIterations ?? this.numIterations,
      adjustHighLats: adjustHighLats ?? this.adjustHighLats,
      timeFormat: timeFormat ?? this.timeFormat,
      calculationMethod: calculationMethod ?? this.calculationMethod,
    );
  }
}
