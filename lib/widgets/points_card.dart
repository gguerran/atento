import 'package:flutter/material.dart';

class PointsCard extends StatelessWidget {
  final String points;
  final String label;
  final String hour;
  const PointsCard(
      {Key? key, required this.points, required this.label, required this.hour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            color: const Color.fromARGB(255, 56, 34, 116),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: SizedBox(
              width: 130,
              height: 130,
              child: Center(
                child: Text(
                  points,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 55,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (hour.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.access_time),
              Padding(
                  padding: const EdgeInsets.only(left: 5), child: Text(hour))
            ],
          )
      ],
    );
  }
}
