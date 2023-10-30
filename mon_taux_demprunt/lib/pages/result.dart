import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';
import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/converter.dart';
import 'package:mon_taux_demprunt/main.dart';

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

    outputData =
        manager.calculator.realCalculator.calculateRate(widget.data);
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
          Text('Nous avons pris en compte les informations suivantes :',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center),
          Column(
            children: [
              SelectableText(
                  'Avec un score de ${outputData!.outData.pointsAmount.toString().replaceAll('.', ',')}/${outputData!.outData.maxPoints}; votre taux de prêt est :',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: SelectableText(
                      '${rateFromScore(outputData!, widget.data, manager.calculatorConfig, manager.calculator.currentFinalOffset).toStringAsFixed(2).replaceAll('.', ',')}%',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          )

        ])));
  }
}
/*
SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingTextStyle: Theme.of(context).textTheme.titleLarge,
                dataTextStyle: Theme.of(context).textTheme.titleMedium,
                columns: const [
                  DataColumn(label: Text('Type de véhicule')),
                  DataColumn(label: Text('Type d\'énergie')),
                  DataColumn(label: Text('Kilométrage annuel')),
                  DataColumn(label: Text('Année de fabrication')),
                  DataColumn(label: Text('Nombre de passager(s)')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                        '${widget.data['vehicle']!['type'].name} (${widget.data['vehicle']!['type'].pointsAmount}/10)')),
                    DataCell(Text(
                        '${widget.data['energy']!['type'].name} (${widget.data['energy']!['type'].pointsAmount}/10)')),
                    DataCell(Text(
                        '${widget.data['mileage']!['category'].name} (${widget.data['mileage']!['category'].pointsAmount}/10)')),
                    DataCell(Text(
                        '${widget.data['year']!['category'].name} (${widget.data['year']!['category'].pointsAmount}/10)')),
                    DataCell(Text('${widget.data['people']!['amount']}')),
                  ]),
                ]),
          ),
 */