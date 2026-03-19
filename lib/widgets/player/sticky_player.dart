import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../providers/app_state_provider.dart';
import '../../utils/theme.dart';
import '../../utils/formatters.dart';

class StickyPlayer extends StatelessWidget {
  const StickyPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, _) {
        final posMs = audio.position.inMilliseconds.toDouble();
        final durMs = audio.duration.inMilliseconds.toDouble();
        final progress = durMs > 0 ? posMs / durMs : 0.0;
        final speed = context.watch<AppStateProvider>().playbackSpeed;

        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.deepBlack.withValues(alpha: 0.88),
                border: Border(
                  top: BorderSide(
                    color: AppColors.accentAmber.withValues(alpha: 0.15),
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress line
                    Container(
                      height: 2,
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: AppColors.amberGradient,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.lg, vertical: Spacing.sm),
                      child: Row(
                        children: [
                          // Title + time
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  audio.currentEpisode.title,
                                  style: const TextStyle(
                                    color: AppColors.textMain,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${formatDuration(audio.position)} / ${formatDuration(audio.duration)}',
                                  style: AppTypography.monoSm(context),
                                ),
                              ],
                            ),
                          ),

                          // Speed pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.accentAmber.withValues(alpha: 0.08),
                              border: Border.all(
                                  color: AppColors.borderSubtle),
                              borderRadius:
                                  BorderRadius.circular(Radii.pill),
                            ),
                            child: Text(
                              '${speed}x',
                              style: const TextStyle(
                                color: AppColors.accentGold,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.sm),

                          // Skip back
                          _miniButton(
                            Icons.replay_10_rounded,
                            audio.skipBackward,
                          ),

                          // Play/Pause
                          GestureDetector(
                            onTap: audio.togglePlayPause,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.amberGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accentAmber
                                        .withValues(alpha: 0.15),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: Icon(
                                audio.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),

                          // Skip forward
                          _miniButton(
                            Icons.forward_10_rounded,
                            audio.skipForward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _miniButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xs),
        child: Icon(icon, color: AppColors.textSecondary, size: 22),
      ),
    );
  }
}
