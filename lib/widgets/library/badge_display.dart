import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class BadgeDisplay extends StatelessWidget {
  final int count;

  const BadgeDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    if (count >= 3) {
      return Semantics(
        label: 'Mastered',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            gradient: AppColors.amberGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentAmber.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Text(
            'MASTER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ),
      );
    }

    return Semantics(
      label: 'Listened $count time${count > 1 ? 's' : ''}',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          count,
          (i) => Padding(
            padding: EdgeInsets.only(left: i > 0 ? 2 : 0),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGold,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGold.withValues(alpha: 0.4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
