import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';
import '../../utils/theme.dart';
import '../../utils/category_colors.dart';
import '../primitives/app_chip.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final categories = library.categories;
    final hPad = Responsive.horizontalPadding(context);

    return Semantics(
      label: 'Episode categories',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: Spacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section label
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: Text(
                'CATEGORIES',
                style: AppTypography.labelSm(context),
              ),
            ),
            // Wrapped pills — fully visible, no horizontal scroll needed
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                AppChip(
                  label: 'All',
                  selected: library.activeCategory == null,
                  onTap: () => library.setCategory(null),
                  accentColor: AppColors.accentAmber,
                  compact: true,
                ),
                ...categories.map((cat) => AppChip(
                      label: getCategoryShortName(cat),
                      selected: library.activeCategory == cat,
                      onTap: () => library.setCategory(
                          library.activeCategory == cat ? null : cat),
                      accentColor: getCategoryColor(cat),
                      compact: true,
                      leading: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getCategoryColor(cat),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
