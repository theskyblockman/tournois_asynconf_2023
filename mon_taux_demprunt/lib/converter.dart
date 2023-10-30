import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';

double rateFromScore(OutputData outputData, InputData inputData, Map<String, dynamic> config, double offset) {
  Map<(int fromScore, int toScore), double> scoreToRateConversionTable = {};

  List<dynamic> scoreToRate = config['converter']['score_to_rate'];

  for (int i = 0; i < scoreToRate.length; i++) {
    var rawRule = scoreToRate[i];
    scoreToRateConversionTable[(rawRule['from'], rawRule['to'])] = rawRule['rate'];
  }

  double? currentRate;

  scoreToRateConversionTable.forEach((key, value) {
    if (outputData.outData.pointsAmount >= key.$1 &&
        outputData.outData.pointsAmount <= key.$2) {
      currentRate = value;
    }
  });

  currentRate ??= 3;

  // Can't do better because of Dart type safety
  currentRate = currentRate! + offset;

  return currentRate!;
}
