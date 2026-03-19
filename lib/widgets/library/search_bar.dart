import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/library_provider.dart';
import '../../utils/theme.dart';

class EpisodeSearchBar extends StatefulWidget {
  const EpisodeSearchBar({super.key});

  @override
  State<EpisodeSearchBar> createState() => _EpisodeSearchBarState();
}

class _EpisodeSearchBarState extends State<EpisodeSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final resultCount = library.filteredEpisodes.length;
    final isSearching = _controller.text.isNotEmpty;
    final hPad = Responsive.horizontalPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: Spacing.sm),
      child: Semantics(
        label: 'Search episodes',
        textField: true,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style:
              AppTypography.body(context).copyWith(color: AppColors.textMain),
          decoration: InputDecoration(
            hintText: 'Search episodes, topics, abbreviations...',
            prefixIcon: const Icon(Icons.search_rounded,
                color: AppColors.textFaint, size: 18),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSearching)
                  Padding(
                    padding: const EdgeInsets.only(right: Spacing.sm),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentAmber.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(Radii.pill),
                      ),
                      child: Text(
                        '$resultCount',
                        style: const TextStyle(
                          color: AppColors.accentGold,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                if (isSearching)
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textMuted, size: 18),
                    onPressed: () {
                      _controller.clear();
                      context.read<LibraryProvider>().setSearchTerm('');
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          onChanged: (value) {
            setState(() {});
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 300), () {
              context.read<LibraryProvider>().setSearchTerm(value);
            });
          },
        ),
      ),
    );
  }
}
