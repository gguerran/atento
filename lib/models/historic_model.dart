import 'package:equatable/equatable.dart';

class HistoricModel extends Equatable {
  final String to;
  final int points;
  final String time;

  const HistoricModel({
    required this.to,
    required this.points,
    required this.time,
  });

  @override
  String toString() => "Histórico: $to; $points Pontos às $time";

  @override
  List<Object?> get props => [to, points, time];

  @override
  bool? get stringify => true;

  bool isEqual(HistoricModel other) =>
      to == other.to && points == other.points && time == other.time;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ? true : other is HistoricModel && isEqual(other);

  @override
  int get hashCode => to.hashCode ^ points.hashCode ^ time.hashCode;
}
