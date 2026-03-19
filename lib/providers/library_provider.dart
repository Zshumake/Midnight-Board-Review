import 'package:flutter/foundation.dart';
import '../models/episode.dart';
import '../services/search_service.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Episode> _allEpisodes;
  final SearchService _search = SearchService();

  String? _activeCategory;
  String _searchTerm = '';

  LibraryProvider(this._allEpisodes);

  String? get activeCategory => _activeCategory;
  String get searchTerm => _searchTerm;

  List<Episode> get filteredEpisodes => _search.filter(
        episodes: _allEpisodes,
        category: _activeCategory,
        searchTerm: _searchTerm,
      );

  List<String> get categories {
    final seen = <String>{};
    final result = <String>[];
    for (final ep in _allEpisodes) {
      if (seen.add(ep.category)) {
        result.add(ep.category);
      }
    }
    return result;
  }

  void setCategory(String? category) {
    _activeCategory = category;
    notifyListeners();
  }

  void setSearchTerm(String term) {
    _searchTerm = term;
    notifyListeners();
  }
}
