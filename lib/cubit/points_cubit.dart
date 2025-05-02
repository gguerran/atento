import 'package:atento/models/historic_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit()
      : super(
          PointsState(
            lastWe: PointsState.nowString,
            lastThey: PointsState.nowString,
          ),
        );
  static const String _weLabel = "Nós";
  static const String _theyLabel = "Eles";

  void zerar() {
    emit(
      state.copyWith(
        counterWe: 0,
        counterThey: 0,
        lastWe: PointsState.nowString,
        lastThey: PointsState.nowString,
        tentos: state.trucoType == TrucoType.paulista ? 1 : 2,
        value: TrucoValue.simples,
        historic: [],
      ),
    );
  }

  void incrementWe(int value) {
    List<HistoricModel> historic = [...state.historic];
    historic.insert(
      0,
      HistoricModel(to: _weLabel, points: value, time: state.lastWe),
    );

    emit(
      state.copyWith(
        counterWe: state.counterWe + value,
        lastWe: PointsState.nowString,
        historic: historic,
        value: TrucoValue.simples,
        tentos: state.trucoType == TrucoType.paulista ? 1 : 2,
      ),
    );
  }

  void incrementThey(int value) {
    List<HistoricModel> historic = [...state.historic];
    historic.insert(
      0,
      HistoricModel(to: _theyLabel, points: value, time: state.lastThey),
    );

    emit(
      state.copyWith(
        counterThey: state.counterThey + value,
        lastThey: PointsState.nowString,
        historic: historic,
        value: TrucoValue.simples,
        tentos: state.trucoType == TrucoType.paulista ? 1 : 2,
      ),
    );
  }

  void getTrucoAccept() {
    switch (state.value) {
      case TrucoValue.simples:
        emit(
          state.copyWith(
            value: TrucoValue.truco,
            tentos: state.trucoType == TrucoType.paulista ? 3 : 4,
          ),
        );
        break;
      case TrucoValue.truco:
        emit(state.copyWith(
          value: TrucoValue.seis,
          tentos: state.trucoType == TrucoType.paulista ? 6 : 8,
        ));
        break;
      case TrucoValue.seis:
        emit(
          state.copyWith(
            value: TrucoValue.nove,
            tentos: state.trucoType == TrucoType.paulista ? 9 : 10,
          ),
        );
        break;
      case TrucoValue.nove:
        emit(
          state.copyWith(
            value: TrucoValue.doze,
            tentos: state.trucoType == TrucoType.paulista ? 12 : 14,
          ),
        );
        break;
      case TrucoValue.doze:
        emit(
          state.copyWith(
            value: TrucoValue.simples,
            tentos: state.trucoType == TrucoType.paulista ? 1 : 2,
          ),
        );
        break;
    }
  }

  void setTrucoType(TrucoType type) {
    emit(
      state.copyWith(
        trucoType: type,
        tentos: type == TrucoType.paulista ? 1 : 2,
      ),
    );
    zerar();
  }
}
