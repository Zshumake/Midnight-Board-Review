import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../providers/app_state_provider.dart';
import '../../utils/theme.dart';

class SpeedSelector extends StatelessWidget {
  const SpeedSelector({super.key});

  static const _speeds = [1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  Widget build(BuildContext context) {
    final currentSpeed =
        context.select<AppStateProvider, double>((s) => s.playbackSpeed);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _speeds.map((speed) {
        final selected = speed == currentSpeed;
        return GestureDetector(
          onTap: () => context.read<AudioProvider>().setSpeed(speed),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.accentAmber.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? AppColors.accentAmber
                    : AppColors.borderSubtle,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: selected
                    ? AppColors.accentGold
                    : AppColors.textFaint,
                fontSize: selected ? 13 : 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
              child: Text('${speed}x'),
            ),
          ),
        );
      }).toList(),
    );
  }
}
