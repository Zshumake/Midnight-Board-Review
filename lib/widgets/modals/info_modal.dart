import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class InfoModal extends StatelessWidget {
  const InfoModal({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim, secondAnim, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, anim, secondAnim) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 420,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: const InfoModal(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(Radii.xl),
          border: Border.all(color: AppColors.borderSubtle),
          boxShadow: AppShadows.elevated,
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hero header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Spacing.xl),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.5,
                    colors: [
                      AppColors.accentAmber.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Spacing.md),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.amberGradient,
                        boxShadow: AppShadows.glow,
                      ),
                      child: const Icon(Icons.headphones_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(height: Spacing.md),
                    Text('Midnight Board Review',
                        style: AppTypography.headline(context)),
                    const SizedBox(height: Spacing.xs),
                    Text('PM&R Board Exam Podcast',
                        style: AppTypography.label(context)),
                  ],
                ),
              ),

              // Features
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xl, vertical: Spacing.lg),
                child: Column(
                  children: [
                    _feature(Icons.play_circle_outline_rounded, 'Audio Player',
                        'Play, pause, skip, and control playback speed.'),
                    _feature(Icons.bookmark_outline_rounded, 'Auto-Save',
                        'Your position is saved automatically.'),
                    _feature(Icons.emoji_events_outlined, 'Badge System',
                        'Listen to 80% to earn a badge. 3 badges = MASTER.'),
                    _feature(Icons.search_rounded, 'Smart Search',
                        'Search by title or abbreviation (TBI, CVA, EDX).'),
                    _feature(Icons.rss_feed_rounded, 'RSS Feed',
                        'Add to Apple Podcasts or any podcast app.'),
                  ],
                ),
              ),

              // Close
              Padding(
                padding: const EdgeInsets.only(
                    bottom: Spacing.lg, right: Spacing.xl),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Got it',
                        style: TextStyle(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentAmber, size: 18),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.textMain)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
