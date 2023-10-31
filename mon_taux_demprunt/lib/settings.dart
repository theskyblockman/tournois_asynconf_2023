import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.currentConfig});

  final Map<String, dynamic> currentConfig;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? currentEditingConfig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
                'Veillez définir la configuration JSON pour le calculateur',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: TextField(
                controller: TextEditingController(
                    text: jsonEncode(widget.currentConfig)),
                onChanged: (value) {
                  currentEditingConfig = value;
                },
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Configuration',
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      (await SharedPreferences.getInstance())
                          .remove('custom_config');
                      setState(() {
                        currentEditingConfig = null;
                      });
                    },
                    child: const Text('Réinitialiser')),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        Map<String, dynamic> newConfig =
                            currentEditingConfig == null
                                ? widget.currentConfig
                                : jsonDecode(currentEditingConfig!);

                        (await SharedPreferences.getInstance())
                            .setString('custom_config', jsonEncode(newConfig));

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'La configuration a été sauvegardée, rechargez la page pour l\'afficher')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'La configuration n\'est pas valide')));
                        return;
                      }
                    },
                    child: const Text('Sauvegarder')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
