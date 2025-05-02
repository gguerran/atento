import 'package:atento/config/assets.dart';
import 'package:atento/cubit/points_cubit.dart';
import 'package:atento/models/historic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AtentoDrawer extends StatefulWidget {
  const AtentoDrawer({super.key});

  @override
  State<AtentoDrawer> createState() => _AtentoDrawerState();
}

class _AtentoDrawerState extends State<AtentoDrawer> {
  static const String _point = "PONTO";
  static const String _points = "PONTOS";
  static const String _weLabel = "Nós";
  static const String _historicLabel = "Histórico";

  String _getPointsText(HistoricModel element) {
    String text =
        element.points > 0 ? "+${element.points} " : "${element.points} ";
    return text += element.points.abs() == 1 ? _point : _points;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Navigator.of(context).pop,
                ),
              ),
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
                        Text(
                          _historicLabel,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "${state.counterWe} X ${state.counterThey}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const Divider(color: Color(0xFF7B6F72)),
                    if (state.historic.isNotEmpty)
                      ...state.historic.map<Widget>(
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
