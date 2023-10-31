import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';
import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/converter.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.data});

  final InputData data;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  OutputData? outputData;

  @override
  Widget build(BuildContext context) {
    final manager = CalculatorManager.of(context);

    outputData = manager.calculator.realCalculator.calculateRate(widget.data);
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
          Column(
            children: [
              Text('En tenant compte de vos choix, votre score est de :',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              Card(
                color: Color.lerp(Colors.redAccent, Colors.greenAccent, outputData!.outData.pointsAmount / outputData!.outData.maxPoints),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: SelectableText(
                      '${outputData!.outData.pointsAmount.toString().replaceAll('.', ',')}/${outputData!.outData.maxPoints}',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center),
                )
              ),
            ],
          ),
          Column(
            children: [
              SelectableText(
                  'Grâce à ce score, votre taux de prêt est de :',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: SelectableText(
                      '${rateFromScore(outputData!, widget.data, manager.calculatorConfig, manager.calculator.currentFinalOffset).toStringAsFixed(2).replaceAll('.', ',')}%',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center)
                ),
              ),
            ],
          )
        ])));
  }
}