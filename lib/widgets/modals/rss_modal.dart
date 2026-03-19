import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class RssModal extends StatelessWidget {
  const RssModal({super.key});

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
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.15),
              end: Offset.zero,
            ).animate(
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
          child: const RssModal(),
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
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(Spacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accentAmber.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(Radii.sm),
                    ),
                    child: const Icon(Icons.rss_feed_rounded,
                        color: AppColors.accentAmber, size: 20),
                  ),
                  const SizedBox(width: Spacing.md),
                  Text('RSS Feed',
                      style: AppTypography.headlineSm(context)),
                ],
              ),
              const SizedBox(height: Spacing.lg),

              Text('Add this feed to your podcast app:',
                  style: AppTypography.bodySm(context)),
              const SizedBox(height: Spacing.md),

              // URL container
              Container(
                padding: const EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.deepBlack,
                  borderRadius: BorderRadius.circular(Radii.sm),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        rssFeedUrl,
                        style: AppTypography.mono(context).copyWith(
                            color: AppColors.accentGold, fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: Spacing.sm),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              const ClipboardData(text: rssFeedUrl));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Copied!')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(Spacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.accentAmber
                                .withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(Radii.sm),
                          ),
                          child: const Icon(Icons.copy_rounded,
                              color: AppColors.accentAmber, size: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.xl),

              Text('APPLE PODCASTS',
                  style: AppTypography.label(context)),
              const SizedBox(height: Spacing.sm),
              Text(
                '1. Open Apple Podcasts\n'
                '2. Library > Shows > ··· menu\n'
                '3. "Follow a Show by URL"\n'
                '4. Paste the feed URL',
                style: AppTypography.bodySm(context).copyWith(height: 1.8),
              ),
              const SizedBox(height: Spacing.xl),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done',
                      style: TextStyle(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
