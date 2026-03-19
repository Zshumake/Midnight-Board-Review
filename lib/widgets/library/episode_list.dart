import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/episodes_data.dart';
import '../../providers/library_provider.dart';
import '../../utils/theme.dart';
import 'episode_tile.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final filtered = library.filteredEpisodes;

    if (filtered.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Spacing.xxxl),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Spacing.xl),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgCard,
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: const Icon(Icons.search_off_rounded,
                    color: AppColors.textFaint, size: 36),
              ),
              const SizedBox(height: Spacing.lg),
              Text(
                'No episodes found',
                style: AppTypography.headlineSm(context)
                    .copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                'Try a different search or category',
                style: AppTypography.bodySm(context),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Result count header
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
          ),
          child: Text(
            '${filtered.length} EPISODE${filtered.length != 1 ? 'S' : ''}',
            style: AppTypography.labelSm(context),
          ),
        ),
        const SizedBox(height: Spacing.sm),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          itemBuilder: (context, i) {
            final episode = filtered[i];
            final globalIndex = allEpisodes.indexOf(episode);
            return EpisodeTile(
              episode: episode,
              index: globalIndex,
            );
          },
        ),
      ],
    );
  }
}
