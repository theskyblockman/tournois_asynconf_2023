// TODO: Put public facing types in this file.

typedef PointData = ({double pointsAmount, int maxPoints});
typedef InputData = Map<int, dynamic>;
typedef OutputData = ({
  PointData outData,
  int ignoredPoints,
  double ignoredPointsAmount
});

class RateRule {
  /// Only called when meetsRequirement is ``true`` else when
  /// Returns The ``pointsAmount`` out of ``maxPoints`` to be added to the global rating.
  final PointData Function(InputData data) calculateRate;
  final bool Function(InputData data) meetsRequirements;

  const RateRule({required this.calculateRate, required this.meetsRequirements});
}

class BorrowingRateCalculator {
  OutputData calculateRate(InputData data) {
    int ignoredPoints = 0;
    double ignoredPointsAmount = 0;
    final points = rules
        .where((rule) {
          if (rule.meetsRequirements(data)) {
            return true;
          } else {
            ignoredPointsAmount += rule.calculateRate(data).maxPoints;
            ignoredPoints++;
            return false;
          }
        })
        .map((rule) => rule.calculateRate(data))
        .reduce((value, element) => (
              pointsAmount: value.pointsAmount + element.pointsAmount,
              maxPoints: value.maxPoints + element.maxPoints
            ));
    return (
      outData: points,
      ignoredPoints: ignoredPoints,
      ignoredPointsAmount: ignoredPointsAmount
    );
  }

  final List<RateRule> rules;

  const BorrowingRateCalculator({required this.rules});
}
