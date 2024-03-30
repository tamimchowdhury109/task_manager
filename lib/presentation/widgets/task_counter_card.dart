import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/status_color_widget.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    super.key,
    required this.amount,
    required this.title,
  });

  final int amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 100,
      child: Card(
        color: StatusBackgroundColors.getColor(title).withOpacity(0.8),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: Center(
            child: Column(
              children: [
                Text(
                  '$amount',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}