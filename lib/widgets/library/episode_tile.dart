import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/episode.dart';
import '../../providers/audio_provider.dart';
import '../../providers/app_state_provider.dart';
import '../../utils/theme.dart';
import '../../utils/category_colors.dart';
import 'badge_display.dart';

class EpisodeTile extends StatefulWidget {
  final Episode episode;
  final int index;

  const EpisodeTile({super.key, required this.episode, required this.index});

  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  bool _expanded = false;
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioProvider>();
    final appState = context.watch<AppStateProvider>();
    final isActive = audio.currentIndex == widget.index;
    final progress = appState.getProgressPercentage(widget.episode.title);
    final completions = appState.getCompletionCount(widget.episode.title);
    final hasDescription = widget.episode.description.isNotEmpty;
    final catColor = getCategoryColor(widget.episode.category);
    final hPad = Responsive.horizontalPadding(context);

    return Semantics(
      label:
          '${widget.episode.title}. ${completions >= 3 ? "Mastered" : completions > 0 ? "Listened $completions times" : "Not listened"}',
      button: true,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (isActive) {
              audio.togglePlayPause();
            } else {
              audio.loadEpisode(widget.index);
            }
          },
          onLongPress: completions > 0
              ? () => _showResetDialog(context, appState)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: EdgeInsets.symmetric(horizontal: hPad, vertical: 2),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.accentAmber.withValues(alpha: 0.05)
                  : _hovering
                      ? AppColors.bgCardHover
                      : AppColors.bgCard,
              borderRadius: BorderRadius.circular(Radii.md),
              border: Border.all(
                color: isActive
                    ? AppColors.accentAmber.withValues(alpha: 0.35)
                    : _hovering
                        ? AppColors.borderMedium
                        : AppColors.borderSubtle,
                width: isActive ? 1.5 : 1,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.accentAmber.withValues(alpha: 0.08),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main row
                Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Row(
                    children: [
                      // Category color bar
                      Container(
                        width: 3,
                        height: 32,
                        margin: const EdgeInsets.only(right: Spacing.md),
                        decoration: BoxDecoration(
                          color: catColor.withValues(
                              alpha: isActive ? 1.0 : 0.6),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Play icon
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.accentAmber.withValues(alpha: 0.12)
                              : Colors.transparent,
                        ),
                        child: Icon(
                          isActive && audio.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: isActive
                              ? AppColors.accentAmber
                              : _hovering
                                  ? AppColors.textSecondary
                                  : AppColors.textFaint,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: Spacing.sm),

                      // Title + preview
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.episode.title,
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.textMain
                                    : _hovering
                                        ? AppColors.textMain
                                        : AppColors.textSecondary,
                                fontWeight: isActive
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 13,
                                height: 1.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (hasDescription && !_expanded)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: Spacing.xxs),
                                child: Text(
                                  widget.episode.description,
                                  style: AppTypography.bodySm(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Badges
                      if (completions > 0) ...[
                        const SizedBox(width: Spacing.sm),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: BadgeDisplay(
                              key: ValueKey(completions),
                              count: completions),
                        ),
                      ],

                      // Expand toggle
                      if (hasDescription)
                        GestureDetector(
                          onTap: () =>
                              setState(() => _expanded = !_expanded),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(Spacing.xs),
                            child: AnimatedRotation(
                              turns: _expanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.expand_more_rounded,
                                color: _hovering
                                    ? AppColors.textMuted
                                    : AppColors.textFaint,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Expanded description
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    padding: const EdgeInsets.only(
                      left: 52,
                      right: Spacing.lg,
                      bottom: Spacing.md,
                    ),
                    child: Text(
                      widget.episode.description,
                      style:
                          AppTypography.bodySm(context).copyWith(height: 1.6),
                    ),
                  ),
                  crossFadeState: _expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),

                // Progress bar
                if (progress > 0)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(Radii.md),
                      bottomRight: Radius.circular(Radii.md),
                    ),
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: Colors.transparent,
                      color: catColor.withValues(alpha: 0.4),
                      minHeight: 2,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, AppStateProvider appState) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: Text('Clear badges for "${widget.episode.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              appState.resetCompletion(widget.episode.title);
              Navigator.pop(ctx);
            },
            child: const Text('Reset',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
