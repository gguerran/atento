import 'dart:math';

import 'package:atento/config/assets.dart';
import 'package:atento/cubit/points_cubit.dart';
import 'package:atento/widgets/atento_drawer.dart';
import 'package:atento/widgets/blue_button.dart';
import 'package:atento/widgets/less_button.dart';
import 'package:atento/widgets/more_button.dart';
import 'package:atento/widgets/points_card.dart';
import 'package:atento/widgets/truco_button_type.dart';
import 'package:atento/widgets/white_button.dart';
import 'package:atento/widgets/win_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _zerarLabel = "Zerar";
  static const String _weLabel = "Nós";
  static const String _theyLabel = "Eles";
  static const String _win = "Ganhamo!";
  static const String _loss = "Perdemo!";
  static const String _willRun = "Vai correr?";
  static const String _accept = "Aceitar";
  static const String _run = "Correr";

  final AudioPlayer _player = AudioPlayer();

  void _showWinLossDialog(String message, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<PointsCubit>(),
        child: WinDialog(
          message: message,
          actions: [
            BlueButtom(
              onPressed: () {
                context.read<PointsCubit>().zerar();
                Navigator.of(context).pop();
              },
              text: _zerarLabel,
            ),
          ],
        ),
      ),
    );
  }

  void _showTrucoDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<PointsCubit>(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          content: TrucoAssets.duck,
          contentPadding: EdgeInsets.zero,
          title: Center(
            child: Text(
              _willRun,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actionsPadding: const EdgeInsets.all(12),
          actions: [
            BlueButtom(
              onPressed: () {
                _getTrucoAccept();
                context.read<PointsCubit>().getTrucoAccept();
                Navigator.of(context).pop();
              },
              text: _accept,
            ),
            BlueButtom(
              onPressed: () {
                _playMusic(
                  "sounds/correr/${Random().nextInt(18)}.ogg",
                );
                Navigator.of(context).pop();
              },
              text: _run,
            ),
          ],
        ),
      ),
    );
  }

  void _incrementWe(int value, BuildContext context) {
    context.read<PointsCubit>().incrementWe(value);
    PointsState state = context.read<PointsCubit>().state;
    if (state.counterWe >= 12) _showWinLossDialog(_win, context);
  }

  void _incrementThey(int value, BuildContext context) {
    context.read<PointsCubit>().incrementThey(value);
    PointsState state = context.read<PointsCubit>().state;
    if (state.counterThey >= 12) _showWinLossDialog(_loss, context);
  }

  Future<void> _playMusic(String path) async {
    AssetSource source = AssetSource(path);
    await _player.play(source);
  }

  void _getTrucoPressed(TrucoValue value) {
    switch (value) {
      case TrucoValue.simples:
        _playMusic("sounds/truco/${Random().nextInt(15)}.ogg");
        break;
      case TrucoValue.truco:
        _playMusic("sounds/seis/${Random().nextInt(12)}.ogg");
        break;
      case TrucoValue.seis:
        _playMusic("sounds/nove/${Random().nextInt(10)}.ogg");
        break;
      case TrucoValue.nove:
        _playMusic("sounds/doze/${Random().nextInt(8)}.ogg");
        break;
      default:
        break;
    }
  }

  void _getTrucoAccept() {
    _playMusic("sounds/aceitar/${Random().nextInt(13)}.ogg");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PointsCubit(),
      child: BlocBuilder<PointsCubit, PointsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              leading: Builder(
                builder: (context) => Container(
                  margin: const EdgeInsets.only(top: 16, left: 16),
                  child: IconButton(
                    icon: const Icon(Icons.history, color: Color(0xFF130F26)),
                    onPressed: Scaffold.of(context).openDrawer,
                  ),
                ),
              ),
            ),
            drawer: AtentoDrawer(),
            backgroundColor: const Color(0xFF190E38),
            body: ListView(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TrucoTypeButtom(
                      image: TrucoAssets.paulista,
                      onPressed: () {
                        context.read<PointsCubit>().setTrucoType(
                              TrucoType.paulista,
                            );
                      },
                      isSelected: state.trucoType == TrucoType.paulista,
                    ),
                    TrucoTypeButtom(
                      image: TrucoAssets.mineiro,
                      onPressed: () {
                        context.read<PointsCubit>().setTrucoType(
                              TrucoType.mineiro,
                            );
                      },
                      isSelected: state.trucoType == TrucoType.mineiro,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    state.trucoType.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PointsCard(
                      points: state.counterWe.toString(),
                      label: _weLabel,
                      hour: state.lastWe,
                    ),
                    Center(
                      child: Text(
                        "X",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    PointsCard(
                      points: state.counterThey.toString(),
                      label: _theyLabel,
                      hour: state.lastThey,
                    )
                  ],
                ),
                const SizedBox(height: 50),
                BlueButtom(
                  onPressed: () {
                    _getTrucoPressed(state.value);
                    _showTrucoDialog(context);
                  },
                  text: state.trucoLabel,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MorePointsButton(
                      onPressed: () => _incrementWe(state.tentos, context),
                      points: state.tentos,
                    ),
                    MorePointsButton(
                      onPressed: () => _incrementThey(state.tentos, context),
                      points: state.tentos,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LessPointsButton(
                      onPressed: state.counterWe > 0
                          ? () => _incrementWe(
                                state.trucoType == TrucoType.paulista ? -1 : -2,
                                context,
                              )
                          : null,
                      points: state.trucoType == TrucoType.paulista ? 1 : 2,
                    ),
                    LessPointsButton(
                      onPressed: state.counterThey > 0
                          ? () => _incrementThey(
                                state.trucoType == TrucoType.paulista ? -1 : -2,
                                context,
                              )
                          : null,
                      points: state.trucoType == TrucoType.paulista ? 1 : 2,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                WhiteButtom(
                  onPressed: context.read<PointsCubit>().zerar,
                  text: _zerarLabel,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
