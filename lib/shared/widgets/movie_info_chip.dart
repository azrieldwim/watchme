import 'package:flutter/material.dart';
import 'package:watchme/config/theme/app_colors.dart';

class MovieInfoChip extends StatelessWidget {
  final String label;

  const MovieInfoChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.white, fontSize: 10),
      ),
    );
  }
}
