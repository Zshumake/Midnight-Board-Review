import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/audio_provider.dart';
import '../../providers/app_state_provider.dart';
import '../../utils/theme.dart';
import '../../utils/category_colors.dart';
import '../library/badge_display.dart';
import '../primitives/app_card.dart';
import 'play_controls.dart';
import 'progress_bar.dart';
import 'speed_selector.dart';

class MainPlayer extends StatelessWidget {
  const MainPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final hPad = Responsive.horizontalPadding(context);

    return Consumer<AudioProvider>(
      builder: (context, audio, _) {
        final episode = audio.currentEpisode;
        final completions =
            context.watch<AppStateProvider>().getCompletionCount(episode.title);
        final catColor = getCategoryColor(episode.category);

        return Semantics(
          label: 'Now playing: ${episode.title}',
          child: AppCard(
            glow: true,
            gradient: true,
            margin: EdgeInsets.symmetric(horizontal: hPad),
            padding: EdgeInsets.all(isMobile ? Spacing.lg : Spacing.xl),
            child: Column(
              children: [
                // Cover art with layered shadow
                _buildCoverArt(isMobile),
                SizedBox(height: isMobile ? Spacing.lg : Spacing.xl),

                // Episode title
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  child: Text(
                    episode.title,
                    key: ValueKey(episode.title),
                    style: isMobile
                        ? AppTypography.headlineSm(context)
                        : AppTypography.headline(context),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Badges
                if (completions > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.sm),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: BadgeDisplay(
                          key: ValueKey(completions), count: completions),
                    ),
                  ),

                const SizedBox(height: Spacing.sm),

                // Category tag
                _buildCategoryTag(catColor, episode.category),
                SizedBox(height: isMobile ? Spacing.lg : Spacing.xl),

                // Progress bar
                const ProgressBar(),
                const SizedBox(height: Spacing.sm),

                // Play controls
                const PlayControls(),
                const SizedBox(height: Spacing.md),

                // Speed selector
                const SpeedSelector(),

                // Error
                if (audio.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.md),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.md, vertical: Spacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Radii.sm),
                        border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: 14),
                          const SizedBox(width: Spacing.xs),
                          Flexible(
                            child: Text(
                              audio.error!,
                              style: const TextStyle(
                                  color: AppColors.error, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoverArt(bool isMobile) {
    final size = isMobile ? 180.0 : 220.0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.accentAmber.withValues(alpha: 0.06),
            blurRadius: 48,
            spreadRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radii.lg),
        child: Image.asset(
          'assets/cover.jpg',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, e, st) => Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              gradient: AppColors.cardGradient,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.headphones_rounded,
                    size: size * 0.3, color: AppColors.textFaint),
                const SizedBox(height: Spacing.sm),
                Text(
                  'MBR',
                  style: TextStyle(
                    color: AppColors.textFaint,
                    fontSize: size * 0.08,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTag(Color catColor, String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: catColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(color: catColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: catColor,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            getCategoryShortName(category).toUpperCase(),
            style: TextStyle(
              color: catColor.withValues(alpha: 0.85),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
