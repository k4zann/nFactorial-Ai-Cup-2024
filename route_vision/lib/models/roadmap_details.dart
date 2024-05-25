class RoadmapDetails{
  final String direction;
  final int hoursPerDay;
  final int months;
  final String learningMethod;
  final int? weekNumber;

  RoadmapDetails({
    required this.direction,
    required this.hoursPerDay,
    required this.months,
    required this.learningMethod,
    this.weekNumber
  });
}