class HistoricModel {
  final String to;
  final int points;
  final String time;

  HistoricModel({required this.to, required this.points, required this.time});

  @override
  String toString() {
    return "Histórico: $to; $points Pontos às $time";
  }
}
