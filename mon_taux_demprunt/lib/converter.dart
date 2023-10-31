import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';
import 'package:flutter/material.dart';

double rateFromScore(OutputData outputData, InputData inputData,
    Map<String, dynamic> config, double offset) {
  Map<(int fromScore, int toScore), double> scoreToRateConversionTable = {};

  List<dynamic> scoreToRate = config['converter']['score_to_rate'];

  for (int i = 0; i < scoreToRate.length; i++) {
    var rawRule = scoreToRate[i];
    scoreToRateConversionTable[(rawRule['from'], rawRule['to'])] =
        rawRule['rate'];
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

class Calculator {
  late BorrowingRateCalculator realCalculator;
  double currentFinalOffset = 0;

  Calculator(Map<String, dynamic> calculatorConfig) {
    List<dynamic> rawRules = calculatorConfig['ruleset'];

    List<RateRule> rules = [];

    for (int i = 0; i < rawRules.length; i++) {
      var rawRule = rawRules[i];
      if (rawRule['type'] == 'modifier') {
        rules.add(RateRule(
            calculateRate: (data) {
              currentFinalOffset += data[i] as double;
              return (pointsAmount: 0, maxPoints: 0);
            },
            meetsRequirements: (data) => data.containsKey(i)));
      } else {
        rules.add(RateRule(
          calculateRate: (data) =>
              (pointsAmount: data[i], maxPoints: rawRule['total_weight']),
          meetsRequirements: (data) => data.containsKey(i),
        ));
      }
    }

    realCalculator = BorrowingRateCalculator(rules: rules);
  }
}

class CalculatorManager extends InheritedWidget {
  CalculatorManager({
    super.key,
    required this.calculatorConfig,
    required Widget child,
  })  : calculator = Calculator(calculatorConfig),
        super(child: child);

  final Map<String, dynamic> calculatorConfig;
  final Calculator calculator;

  static CalculatorManager of(BuildContext context) {
    final CalculatorManager? result =
        context.dependOnInheritedWidgetOfExactType<CalculatorManager>();
    assert(result != null, 'No CalculatorManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CalculatorManager oldWidget) {
    return oldWidget.calculator != calculator;
  }
}
