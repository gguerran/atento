import 'package:flutter/material.dart';

class PointsCard extends StatelessWidget {
  final String points;
  final String label;
  final String hour;
  const PointsCard({
    super.key,
    required this.points,
    required this.label,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.displayMedium,
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
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ),
        ),
        if (hour.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  hour,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              )
            ],
          )
      ],
    );
  }
}
