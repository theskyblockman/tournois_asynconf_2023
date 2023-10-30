import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/data.dart';
import 'package:mon_taux_demprunt/pages/builder.dart';

class YearPage extends StatelessWidget {
  const YearPage(
      {super.key,
      required this.onYearCategorySelected,
      required this.nextPage});

  final void Function(Map<String, dynamic> newData) onYearCategorySelected;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return PageBuilder<YearCategory>(
        title: 'Quelle est l\'année de fabrication du véhicule ?',
        possibilities: {
          for (var element in YearCategory.values)
            element.name: element
        },
        onChoiceMade: (selected) {
          onYearCategorySelected({'category': selected});
        },
        nextPage: nextPage);
  }
}
