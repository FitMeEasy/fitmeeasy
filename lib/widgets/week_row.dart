import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WeekRow extends StatelessWidget {
  const WeekRow({super.key, required this.done});

  final List<bool> done; // L..D (7)

  static const _labels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) => _dot(_labels[i], done[i])),
    );
  }

  Widget _dot(String label, bool isDone) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDone ? AppColors.accent : AppColors.card,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isDone ? Colors.white : Colors.white70,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
