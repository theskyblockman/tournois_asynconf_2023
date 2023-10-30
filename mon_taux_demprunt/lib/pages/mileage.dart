import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/data.dart';

import 'builder.dart';

class MileagePage extends StatelessWidget {
  const MileagePage(
      {super.key,
      required this.onMileageCategorySelected,
      required this.nextPage});

  final void Function(Map<String, dynamic> newData) onMileageCategorySelected;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return PageBuilder<MileageCategory>(
        title: 'Combien de kilomètres allez vous parcourir chaque année ?',
        possibilities: {
          for (var element in MileageCategory.values)
            element.name: element
        },
        onChoiceMade: (selected) {
          onMileageCategorySelected({'category': selected});
        },
        nextPage: nextPage);
  }
}
