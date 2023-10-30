import 'package:flutter/material.dart';
import 'package:mon_taux_demprunt/data.dart';
import 'package:mon_taux_demprunt/pages/builder.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage(
      {super.key, required this.onVehicleTypeSelected, required this.nextPage});

  final void Function(Map<String, dynamic> newData) onVehicleTypeSelected;
  final VoidCallback nextPage;

  @override
  Widget build(BuildContext context) {
    return PageBuilder<VehicleType>(title: 'Sélectionnez votre type de véhicule', possibilities: { for (var element in VehicleType.values) element.name : element }, onChoiceMade: (selected) {
      onVehicleTypeSelected({'type': selected});
    }, nextPage: nextPage);

    /*
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Sélectionnez votre type de véhicule',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center),
                Card(
                    color: const Color(0xffc5f08b),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                          spacing: 30,
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            for (final vehicleType in VehicleType.values)
                              TextButton(
                                  onPressed: () {
                                    debugPrint('Pressed ${vehicleType.name}');
                                    widget.onVehicleTypeSelected(
                                        {'type': vehicleType});
                                    widget.nextPage();
                                  },
                                  child: Text(vehicleType.name,
                                      style: ))
                          ]),
                    ))
              ]),
        ),
      ),
    );
     */
  }
}
