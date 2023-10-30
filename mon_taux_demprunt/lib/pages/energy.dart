import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/data.dart';
import 'package:mon_taux_demprunt/pages/builder.dart';

class EnergyPage extends StatelessWidget {
  const EnergyPage(
      {super.key, required this.onEnergyTypeSelected, required this.nextPage});

  final void Function(Map<String, dynamic> newData) onEnergyTypeSelected;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return PageBuilder<EnergyType>(
        title: 'Sélectionnez le type d\'énergie qu\'utilise votre véhicule',
        possibilities: {
          for (var element in EnergyType.values)
            element.name: element
        },
        onChoiceMade: (selected) {
          onEnergyTypeSelected({'type': selected});
        },
        nextPage: nextPage);
  }
}
