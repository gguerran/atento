part of 'points_cubit.dart';

enum TrucoValue { simples, truco, seis, nove, doze }

enum TrucoType {
  mineiro,
  paulista;

  String get label {
    switch (this) {
      case TrucoType.mineiro:
        return "Mineiro";
      case TrucoType.paulista:
        return "Paulista";
    }
  }
}

class PointsState extends Equatable {
  final int counterWe;
  final int counterThey;
  final String lastWe;
  final String lastThey;
  final int tentos;
  final TrucoValue value;
  final TrucoType trucoType;
  final List<HistoricModel> historic;

  const PointsState({
    this.counterWe = 0,
    this.counterThey = 0,
    required this.lastWe,
    required this.lastThey,
    this.tentos = 1,
    this.value = TrucoValue.simples,
    this.trucoType = TrucoType.paulista,
    this.historic = const [],
  });

  PointsState copyWith({
    int? counterWe,
    int? counterThey,
    String? lastWe,
    String? lastThey,
    int? tentos,
    TrucoValue? value,
    TrucoType? trucoType,
    List<HistoricModel>? historic,
  }) =>
      PointsState(
        counterWe: counterWe ?? this.counterWe,
        counterThey: counterThey ?? this.counterThey,
        lastWe: lastWe ?? this.lastWe,
        lastThey: lastThey ?? this.lastThey,
        tentos: tentos ?? this.tentos,
        value: value ?? this.value,
        trucoType: trucoType ?? this.trucoType,
        historic: historic ?? this.historic,
      );

  @override
  List<Object?> get props => [
        counterWe,
        counterThey,
        lastWe,
        lastThey,
        tentos,
        value,
        trucoType,
        ...historic,
      ];

  static String get nowString => DateFormat.Hms().format(DateTime.now());
  static const String _zerarLabel = "Zerar";
  static const String _trucoLabel = "Truco!";
  static const String _seisLabel = "Seis!";
  static const String _noveLabel = "Nove!";
  static const String _dozeLabel = "Doze!";

  String get trucoLabel {
    switch (value) {
      case TrucoValue.simples:
        return _trucoLabel;
      case TrucoValue.truco:
        return _seisLabel;
      case TrucoValue.seis:
        return _noveLabel;
      case TrucoValue.nove:
        return _dozeLabel;
      case TrucoValue.doze:
        return _zerarLabel;
    }
  }
}
