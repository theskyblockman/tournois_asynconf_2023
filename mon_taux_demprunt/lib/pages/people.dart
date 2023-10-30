import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/pages/builder.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage(
      {super.key,
      required this.onPeopleAmountSelected,
      required this.nextPage});

  final void Function(Map<String, dynamic> newData) onPeopleAmountSelected;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return PageBuilder<int>(
        title: 'Combien de personnes utiliseront le véhicule ?',
        possibilities: {
          for (var personAmount = 1; personAmount <= 4; personAmount++)
            '$personAmount personne${personAmount == 1 ? '' : 's'}': personAmount
        },
        onChoiceMade: (selected) {
          onPeopleAmountSelected({'amount': selected});
        },
        nextPage: nextPage);
  }
}
