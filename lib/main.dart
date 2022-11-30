import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import 'package:atento/config/assets.dart';
import 'package:atento/models/historic_model.dart';
import 'package:atento/widgets/blue_button.dart';
import 'package:atento/widgets/points_button.dart';
import 'package:atento/widgets/points_card.dart';
import 'package:atento/widgets/truco_button_type.dart';
import 'package:atento/widgets/white_button.dart';
import 'package:atento/widgets/win_dialog.dart';

enum TrucoValue { simples, truco, seis, nove, doze }

enum TrucoType { mineiro, paulista }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: const MyHomePage(title: 'A TENTO'),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _zerarLabel = "Zerar";
  static const String _weLabel = "Nós";
  static const String _theyLabel = "Eles";
  static const String _trucoLabel = "Truco!";
  static const String _seisLabel = "Seis!";
  static const String _noveLabel = "Nove!";
  static const String _dozeLabel = "Doze!";
  static const String _win = "Ganhamo!";
  static const String _loss = "Perdemo!";
  static const String _point = "PONTO";
  static const String _points = "PONTOS";
  static const String _willRun = "Vai correr?";
  static const String _accept = "Aceitar";
  static const String _run = "Correr";

  int _counterWe = 0;
  int _counterThey = 0;
  String _lastWe = "";
  String _lastThey = "";
  int _tentos = 1;
  TrucoValue _value = TrucoValue.simples;
  TrucoType _trucoType = TrucoType.paulista;
  final List<HistoricModel> _historic = [];
  AudioPlayer player = AudioPlayer();

  String _getNowString() => DateFormat.Hms().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _lastWe = _getNowString();
    _lastThey = _getNowString();
  }

  void _incrementWe(int value, BuildContext context) {
    setState(() {
      _counterWe += value;
      _lastWe = _getNowString();
      _historic.insert(
        0,
        HistoricModel(to: _weLabel, points: value, time: _lastWe),
      );
    });
    if (_counterWe >= 12) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WinDialog(
          message: _win,
          actions: [
            BlueButtom(
              onPressed: () {
                _zerar();
                Navigator.of(context).pop();
              },
              text: _zerarLabel,
            ),
          ],
        ),
      );
    }
  }

  void _incrementThey(int value, BuildContext context) {
    setState(() {
      _counterThey += value;
      _lastThey = _getNowString();
      _historic.insert(
        0,
        HistoricModel(to: _theyLabel, points: value, time: _lastThey),
      );
    });
    if (_counterThey >= 12) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WinDialog(
          message: _loss,
          actions: [
            BlueButtom(
              onPressed: () {
                _zerar();
                Navigator.of(context).pop();
              },
              text: _zerarLabel,
            ),
          ],
        ),
      );
    }
  }

  void _zerar() {
    setState(() {
      _tentos = _trucoType == TrucoType.paulista ? 1 : 2;
      _counterThey = 0;
      _counterWe = 0;
      _value = TrucoValue.simples;
      _lastWe = _getNowString();
      _lastThey = _getNowString();
      _historic.clear();
    });
  }

  String _getTrucoLabel() {
    switch (_value) {
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

  Future<void> _playMusic(String path) async {
    AssetSource source = AssetSource(path);
    await player.play(source);
  }

  void _getTrucoPressed() {
    switch (_value) {
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
      case TrucoValue.doze:
        break;
    }
  }

  void _getTrucoAccept() {
    _playMusic("sounds/aceitar/${Random().nextInt(13)}.ogg");
    switch (_value) {
      case TrucoValue.simples:
        setState(() {
          _value = TrucoValue.truco;
          _tentos = _trucoType == TrucoType.paulista ? 3 : 4;
        });
        break;
      case TrucoValue.truco:
        setState(() {
          _value = TrucoValue.seis;
          _tentos = _trucoType == TrucoType.paulista ? 6 : 8;
        });
        break;
      case TrucoValue.seis:
        setState(() {
          _value = TrucoValue.nove;
          _tentos = _trucoType == TrucoType.paulista ? 9 : 10;
        });
        break;
      case TrucoValue.nove:
        setState(() {
          _value = TrucoValue.doze;
          _tentos = 12;
        });
        break;
      case TrucoValue.doze:
        setState(() {
          _value = TrucoValue.simples;
          _tentos = _trucoType == TrucoType.paulista ? 1 : 2;
        });
        break;
    }
  }

  String _getPointsText(HistoricModel element) {
    String text =
        element.points > 0 ? "+${element.points} " : "${element.points} ";
    return text += element.points.abs() == 1 ? _point : _points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: const Color(0xFF190E38),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              color: const Color(0xFF130F26),
              icon: const Icon(Icons.more_horiz),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          );
        }),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF92A3FD).withOpacity(0.8),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TrucoTypeButtom(
                    image: TrucoAssets.paulista,
                    onPressed: () {
                      setState(() => _trucoType = TrucoType.paulista);
                      _zerar();
                      Navigator.of(context).pop();
                    },
                  ),
                  TrucoTypeButtom(
                    image: TrucoAssets.mineiro,
                    onPressed: () {
                      setState(() => _trucoType = TrucoType.mineiro);
                      _zerar();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: WhiteButtom(
                onPressed: () {
                  _zerar();
                  Navigator.of(context).pop();
                },
                text: _zerarLabel,
              ),
            ),
            if (_historic.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Histórico",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$_counterWe X $_counterThey",
                          style: const TextStyle(
                            color: Color(0xFF7B6F72),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Color(0xFF7B6F72)),
                    ..._historic
                        .map<Widget>(
                          (element) => Column(
                            children: [
                              ListTile(
                                leading: element.to == _weLabel
                                    ? TrucoAssets.we
                                    : TrucoAssets.they,
                                isThreeLine: true,
                                textColor: const Color(0xFF1D1617),
                                title: Text(element.to),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [Text(_getPointsText(element))],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: Color(0xFF7B6F72),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            element.time,
                                            style: const TextStyle(
                                              color: Color(0xFF7B6F72),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(color: Color(0xFF7B6F72))
                            ],
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF190E38),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 15,
                right: 15,
                top: 35,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PointsCard(
                    points: _counterWe.toString(),
                    label: _weLabel,
                    hour: _lastWe,
                  ),
                  const Center(
                    child: Text(
                      "\nX",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  PointsCard(
                    points: _counterThey.toString(),
                    label: _theyLabel,
                    hour: _lastThey,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: BlueButtom(
                      onPressed: () {
                        _getTrucoPressed();
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.white,
                            content: TrucoAssets.duck,
                            contentPadding: EdgeInsets.zero,
                            title: const Center(
                              child: Text(
                                _willRun,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actionsPadding: const EdgeInsets.all(12),
                            actions: [
                              BlueButtom(
                                onPressed: () {
                                  _getTrucoAccept();
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
                        );
                      },
                      text: _getTrucoLabel(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MorePointsButton(
                    onPressed: () {
                      _incrementWe(_tentos, context);
                      setState(() {
                        _value = TrucoValue.simples;
                        _tentos = _trucoType == TrucoType.paulista ? 1 : 2;
                      });
                    },
                    points: _tentos,
                  ),
                  MorePointsButton(
                    onPressed: () {
                      _incrementThey(_tentos, context);
                      setState(() {
                        _value = TrucoValue.simples;
                        _tentos = _trucoType == TrucoType.paulista ? 1 : 2;
                      });
                    },
                    points: _tentos,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LessPointsButton(
                    onPressed:
                        _counterWe > 0 ? () => _incrementWe(-1, context) : null,
                    points: _trucoType == TrucoType.paulista ? 1 : 2,
                  ),
                  LessPointsButton(
                    onPressed: _counterThey > 0
                        ? () => _incrementThey(
                              _trucoType == TrucoType.paulista ? -1 : -2,
                              context,
                            )
                        : null,
                    points: _trucoType == TrucoType.paulista ? 1 : 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
