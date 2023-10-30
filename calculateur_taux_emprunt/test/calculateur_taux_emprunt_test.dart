import 'package:calculateur_taux_emprunt/calculateur_taux_emprunt.dart';
import 'package:test/test.dart';

enum VehicleType {
  citadine('Citadine', 800, 1300, 8),
  cabriolet('Cabriolet', 1300, 2000, 6),
  berline('Berline', 1300, 1800, 6.5),
  suv_4x4('SUV / 4x4', 1500, 2500, 4);

  final String name;
  final int minWeight;
  final int maxWeight;
  final double pointsAmount;

  const VehicleType(this.name, this.minWeight, this.maxWeight, this.pointsAmount);
}

enum EnergyType {
  essence('Essence', 5),
  electrique('Electrique', 9),
  gaz('Gaz', 6),
  diesel('Diesel', 4),
  hybride('Hybride', 7);

  final String name;
  final double pointsAmount;

  const EnergyType(this.name, this.pointsAmount);
}

enum MileageCategory {
  from5kTo10k(5000, 10000, 9),
  from10kTo15k(10000, 15000, 7),
  from15kTo20k(15000, 20000, 5),
  from20kTo25k(20000, 25000, 3),
  from25kTo30k(25000, 30000, 1);

  final int rangeStart;
  final int rangeEnd;
  final double pointsAmount;

  const MileageCategory(this.rangeStart, this.rangeEnd, this.pointsAmount);
}

enum YearCategory {
  from1960to1970(1960, 1970, 1),
  from1970to1980(1970, 1980, 2),
  from1980to1990(1980, 1990, 3),
  from1990to2000(1990, 2000, 4),
  from2000to2010(2000, 2010, 5),
  from2010(2010, null, 7);

  final int rangeStart;
  final int? rangeEnd;
  final double pointsAmount;

  const YearCategory(this.rangeStart, this.rangeEnd, this.pointsAmount);
}

void main() {
  group('Premade tests', ()
  {
    final calculator = BorrowingRateCalculator(rules: [
      RateRule(calculateRate: (data) {
        Map<String, dynamic> vehicleData = data['vehicle']!;

        VehicleType type = vehicleData['type'];

        return (pointsAmount: type.pointsAmount, maxPoints: 10);
      }, meetsRequirements: (data) => data.containsKey('vehicle')),
      RateRule(
          calculateRate: (data) {
            Map<String, dynamic> vehicleData = data['energy']!;

            EnergyType type = vehicleData['type'];

            return (pointsAmount: type.pointsAmount, maxPoints: 10);
          },
          meetsRequirements: (data) => data.containsKey('energy')),
      RateRule(
          calculateRate: (data) {
            Map<String, dynamic> vehicleData = data['mileage']!;

            MileageCategory category = vehicleData['category'];

            return (pointsAmount: category.pointsAmount, maxPoints: 10);
          },
          meetsRequirements: (data) => data.containsKey('mileage')),
      RateRule(
          calculateRate: (data) {
            Map<String, dynamic> vehicleData = data['year']!;

            YearCategory category = vehicleData['category'];

            return (pointsAmount: category.pointsAmount, maxPoints: 10);
          },
          meetsRequirements: (data) => data.containsKey('year')),
    ]);

    //WONTFIX: Tests cannot be performed because a data is stored in an outsider file
  });
}
