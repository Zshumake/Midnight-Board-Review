import '../models/episode.dart';
import '../data/synonyms_data.dart';

class SearchService {
  List<Episode> filter({
    required List<Episode> episodes,
    required String? category,
    required String searchTerm,
  }) {
    var filtered = episodes;

    // Category filter
    if (category != null && category.isNotEmpty) {
      filtered = filtered.where((e) => e.category == category).toList();
    }

    // Search filter
    if (searchTerm.isNotEmpty) {
      final expandedTerms = _expandSearch(searchTerm.toLowerCase());
      filtered = filtered.where((e) {
        final haystack =
            '${e.title} ${e.category} ${e.description}'.toLowerCase();
        return expandedTerms.any((term) => haystack.contains(term));
      }).toList();
    }

    return filtered;
  }

  List<String> _expandSearch(String query) {
    final terms = <String>[query];

    // Check each word against synonym map
    for (final word in query.split(RegExp(r'\s+'))) {
      final expansion = synonyms[word];
      if (expansion != null) {
        terms.addAll(expansion.split(' '));
      }
    }

    return terms;
  }
}
