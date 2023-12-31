import 'dart:convert';

import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon_taux_demprunt/color_schemes.g.dart';
import 'package:mon_taux_demprunt/converter.dart';
import 'package:mon_taux_demprunt/pages/builder.dart';
import 'package:mon_taux_demprunt/pages/result.dart';

import 'package:mon_taux_demprunt/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late Map<String, dynamic> config;

  if ((await SharedPreferences.getInstance()).containsKey('custom_config')) {
    config = jsonDecode(
        (await SharedPreferences.getInstance()).getString('custom_config')!);
  } else {
    config = jsonDecode(
        await rootBundle.loadString('assets/default_calculator_settings.json'));
  }

  runApp(App(calculatorConfig: config));
}

class App extends StatelessWidget {
  const App({super.key, required this.calculatorConfig});

  final Map<String, dynamic> calculatorConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon taux d\'emprunt',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: HomePage(calculatorConfig: calculatorConfig),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.calculatorConfig});

  final Map<String, dynamic> calculatorConfig;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InputData data = {};
  PageController pageController = PageController();
  Map<String, dynamic> _currentConfig = {};

  Map<String, dynamic> get currentConfig => _currentConfig;
  set currentConfig(Map<String, dynamic> newConfig) {
    setState(() {
      _currentConfig = newConfig;
    });
  }

  void _fieldUpdate(int fieldId, dynamic newData) {
    setState(() {
      data[fieldId] = newData;
    });
  }

  void nextPage() {
    pageController
        .nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut)
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorManager(
        calculatorConfig: currentConfig,
        child: Stack(
          children: [
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    pageController
                        .animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut)
                        .then((value) => data = {});
                  });
                },
                label: const Text('Nouvelle simulation'),
                icon: const Icon(Icons.restart_alt),
              ),
              appBar: AppBar(
                title: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.displaySmall,
                        text:
                            'Outil de calcul de l\'empreinte écologique lancé par ',
                        children: [
                      TextSpan(
                          text: 'la Green Bank',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ])),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage(
                                    currentConfig: currentConfig)));
                      },
                      tooltip: 'Paramètres',
                      icon: const Icon(Icons.settings))
                ],
              ),
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var rule in (currentConfig['ruleset']))
                    PageBuilder(
                        title: rule['title'],
                        possibilities: {
                          for (var element in rule['choices'].entries)
                            element.key: element.value
                        },
                        onChoiceMade: (selected) {
                          _fieldUpdate((currentConfig['ruleset']).indexOf(rule),
                              selected);
                        },
                        nextPage: nextPage),
                  ResultPage(data: data)
                ],
              ),
            ),
            Positioned.fill(
                left: 16,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton.filledTonal(
                      onPressed: pageController.positions.isNotEmpty &&
                              (pageController.page ?? 0) == 0
                          ? null
                          : () {
                              pageController
                                  .previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut)
                                  .then((value) => setState(() {}));
                            },
                      icon: const Icon(Icons.chevron_left)),
                )),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _currentConfig = widget.calculatorConfig;
  }
}
