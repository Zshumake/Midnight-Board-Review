import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../utils/theme.dart';
import '../primitives/app_button.dart';

class PlayControls extends StatelessWidget {
  const PlayControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, _) {
        return Semantics(
          label: 'Playback controls',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous — subtle
              AppIconButton(
                icon: Icons.skip_previous_rounded,
                size: 26,
                color: AppColors.textMuted,
                onPressed: audio.previousEpisode,
                tooltip: 'Previous',
              ),
              const SizedBox(width: Spacing.md),

              // Skip back
              AppIconButton(
                icon: Icons.replay_10_rounded,
                size: 30,
                onPressed: audio.skipBackward,
                tooltip: 'Back 10 seconds',
              ),
              const SizedBox(width: Spacing.lg),

              // Play/Pause — prominent
              audio.isLoading
                  ? Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.amberGradient,
                        boxShadow: AppShadows.glow,
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : AppIconButton(
                      icon: audio.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 36,
                      prominent: true,
                      onPressed: audio.togglePlayPause,
                      tooltip: audio.isPlaying ? 'Pause' : 'Play',
                    ),
              const SizedBox(width: Spacing.lg),

              // Skip forward
              AppIconButton(
                icon: Icons.forward_10_rounded,
                size: 30,
                onPressed: audio.skipForward,
                tooltip: 'Forward 10 seconds',
              ),
              const SizedBox(width: Spacing.md),

              // Next — subtle
              AppIconButton(
                icon: Icons.skip_next_rounded,
                size: 26,
                color: AppColors.textMuted,
                onPressed: audio.nextEpisode,
                tooltip: 'Next',
              ),
            ],
          ),
        );
      },
    );
  }
}
