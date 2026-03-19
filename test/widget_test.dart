import 'package:flutter_test/flutter_test.dart';
import 'package:midnight_board_review/data/episodes_data.dart';
import 'package:midnight_board_review/data/descriptions_data.dart';
import 'package:midnight_board_review/data/synonyms_data.dart';
import 'package:midnight_board_review/models/episode.dart';
import 'package:midnight_board_review/models/app_state.dart';
import 'package:midnight_board_review/services/search_service.dart';
import 'package:midnight_board_review/services/tracking_service.dart';
import 'package:midnight_board_review/utils/formatters.dart';
import 'package:midnight_board_review/utils/category_colors.dart';

void main() {
  // ─── Episode Data ──────────────────────────────────────────────────────

  group('Episode Data', () {
    test('has 120 episodes', () {
      expect(allEpisodes.length, 120);
    });

    test('every episode has a non-empty title', () {
      for (final ep in allEpisodes) {
        expect(ep.title.isNotEmpty, isTrue, reason: 'Empty title found');
      }
    });

    test('every episode has a valid R2 URL', () {
      for (final ep in allEpisodes) {
        expect(ep.url, startsWith('https://'));
        expect(ep.url, endsWith('.m4a'));
      }
    });

    test('every episode has a non-empty category', () {
      for (final ep in allEpisodes) {
        expect(ep.category.isNotEmpty, isTrue,
            reason: '${ep.title} has empty category');
      }
    });

    test('no duplicate titles', () {
      final titles = allEpisodes.map((e) => e.title).toSet();
      expect(titles.length, allEpisodes.length);
    });

    test('no duplicate URLs', () {
      final urls = allEpisodes.map((e) => e.url).toSet();
      expect(urls.length, allEpisodes.length);
    });

    test('allCategories contains expected categories', () {
      expect(allCategories, contains('Pain Medicine'));
      expect(allCategories, contains('Pediatrics'));
      expect(allCategories.length, 14);
    });
  });

  // ─── Descriptions ──────────────────────────────────────────────────────

  group('Descriptions', () {
    test('descriptions map is not empty', () {
      expect(descriptions.isNotEmpty, isTrue);
    });

    test('every episode title has a matching description key', () {
      for (final ep in allEpisodes) {
        expect(descriptions.containsKey(ep.title), isTrue,
            reason: 'Missing description for: ${ep.title}');
      }
    });
  });

  // ─── Synonyms ──────────────────────────────────────────────────────────

  group('Synonyms', () {
    test('synonyms map is not empty', () {
      expect(synonyms.isNotEmpty, isTrue);
    });

    test('common abbreviations are mapped', () {
      expect(synonyms.containsKey('tbi'), isTrue);
      expect(synonyms.containsKey('cva'), isTrue);
      expect(synonyms.containsKey('sci'), isTrue);
      expect(synonyms.containsKey('edx'), isTrue);
    });
  });

  // ─── Search Service ────────────────────────────────────────────────────

  group('SearchService', () {
    final search = SearchService();

    test('returns all episodes with no filters', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: null,
        searchTerm: '',
      );
      expect(result.length, 120);
    });

    test('filters by category', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: 'Pediatrics',
        searchTerm: '',
      );
      expect(result.isNotEmpty, isTrue);
      for (final ep in result) {
        expect(ep.category, 'Pediatrics');
      }
    });

    test('filters by search term', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: null,
        searchTerm: 'shoulder',
      );
      expect(result.isNotEmpty, isTrue);
      for (final ep in result) {
        final hay = '${ep.title} ${ep.category} ${ep.description}'.toLowerCase();
        expect(hay.contains('shoulder'), isTrue);
      }
    });

    test('expands abbreviation synonyms', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: null,
        searchTerm: 'tbi',
      );
      expect(result.isNotEmpty, isTrue);
    });

    test('returns empty for nonsense query', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: null,
        searchTerm: 'xyzzyflorp',
      );
      expect(result.isEmpty, isTrue);
    });

    test('combines category and search filters', () {
      final result = search.filter(
        episodes: allEpisodes,
        category: 'Musculoskeletal: Upper Extremity & Spine',
        searchTerm: 'shoulder',
      );
      expect(result.isNotEmpty, isTrue);
      for (final ep in result) {
        expect(ep.category, 'Musculoskeletal: Upper Extremity & Spine');
      }
    });
  });

  // ─── Tracking Service ──────────────────────────────────────────────────

  group('TrackingService', () {
    test('starts fresh', () {
      final tracker = TrackingService();
      expect(tracker.sessionValidTime, 0);
      expect(tracker.hasCreditedSession, isFalse);
    });

    test('accumulates valid listening time', () {
      final tracker = TrackingService();
      // Simulate 10 seconds of continuous playback
      for (var t = 0.0; t <= 10.0; t += 0.5) {
        tracker.update(t, isPaused: false, isDragging: false);
      }
      expect(tracker.sessionValidTime, greaterThan(8));
    });

    test('does not count paused time', () {
      final tracker = TrackingService();
      tracker.update(0, isPaused: false, isDragging: false);
      tracker.update(1, isPaused: true, isDragging: false);
      tracker.update(2, isPaused: true, isDragging: false);
      tracker.update(3, isPaused: true, isDragging: false);
      expect(tracker.sessionValidTime, lessThan(2));
    });

    test('does not count dragging time', () {
      final tracker = TrackingService();
      tracker.update(0, isPaused: false, isDragging: false);
      tracker.update(1, isPaused: false, isDragging: true);
      tracker.update(50, isPaused: false, isDragging: true); // big jump
      expect(tracker.sessionValidTime, lessThan(2));
    });

    test('awards badge at 80% threshold', () {
      final tracker = TrackingService();
      final duration = 100.0;
      // Simulate listening to 85 seconds
      for (var t = 0.0; t <= 85.0; t += 0.5) {
        tracker.update(t, isPaused: false, isDragging: false);
      }
      expect(tracker.checkCompletion(duration), isTrue);
      expect(tracker.hasCreditedSession, isTrue);
    });

    test('does not double-award badge', () {
      final tracker = TrackingService();
      for (var t = 0.0; t <= 90.0; t += 0.5) {
        tracker.update(t, isPaused: false, isDragging: false);
      }
      expect(tracker.checkCompletion(100), isTrue);
      expect(tracker.checkCompletion(100), isFalse); // second call
    });

    test('reset clears state', () {
      final tracker = TrackingService();
      for (var t = 0.0; t <= 10.0; t += 0.5) {
        tracker.update(t, isPaused: false, isDragging: false);
      }
      tracker.reset();
      expect(tracker.sessionValidTime, 0);
      expect(tracker.hasCreditedSession, isFalse);
    });
  });

  // ─── PersistedState ────────────────────────────────────────────────────

  group('PersistedState', () {
    test('defaults are sane', () {
      final state = PersistedState();
      expect(state.lastIndex, 0);
      expect(state.playbackSpeed, 1.0);
      expect(state.positions, isEmpty);
      expect(state.completions, isEmpty);
    });

    test('round-trips through JSON', () {
      final state = PersistedState(
        lastIndex: 5,
        playbackSpeed: 1.5,
        positions: {'Shoulder 1': 42.5},
        completions: {'Shoulder 1': 2},
      );
      final encoded = state.encode();
      final decoded = PersistedState.decode(encoded);

      expect(decoded.lastIndex, 5);
      expect(decoded.playbackSpeed, 1.5);
      expect(decoded.positions['Shoulder 1'], 42.5);
      expect(decoded.completions['Shoulder 1'], 2);
    });

    test('handles corrupt JSON gracefully', () {
      final state = PersistedState.decode('not valid json{{{');
      expect(state.lastIndex, 0);
      expect(state.playbackSpeed, 1.0);
    });

    test('migrates history to completions', () {
      final state = PersistedState.fromJson({
        'history': ['Episode A', 'Episode B'],
        'completions': {'Episode A': 2},
      });
      expect(state.completions['Episode A'], 2); // kept existing
      expect(state.completions['Episode B'], 1); // migrated from history
    });
  });

  // ─── Formatters ────────────────────────────────────────────────────────

  group('Formatters', () {
    test('formats duration correctly', () {
      expect(formatDuration(const Duration(seconds: 0)), '0:00');
      expect(formatDuration(const Duration(seconds: 5)), '0:05');
      expect(formatDuration(const Duration(seconds: 65)), '1:05');
      expect(formatDuration(const Duration(minutes: 10, seconds: 30)), '10:30');
    });

    test('formatSeconds works', () {
      expect(formatSeconds(0), '0:00');
      expect(formatSeconds(90), '1:30');
    });
  });

  // ─── Category Colors ──────────────────────────────────────────────────

  group('Category Colors', () {
    test('every category in episodes has a color', () {
      final categories = allEpisodes.map((e) => e.category).toSet();
      for (final cat in categories) {
        expect(categoryColors.containsKey(cat), isTrue,
            reason: 'Missing color for: $cat');
      }
    });

    test('getCategoryColor returns fallback for unknown', () {
      final color = getCategoryColor('Nonexistent Category');
      expect(color, isNotNull);
    });

    test('short names exist for long categories', () {
      expect(getCategoryShortName('Neurology: TBI'), 'TBI');
      expect(getCategoryShortName('Electrodiagnostic Medicine (EDX)'), 'EDX');
      expect(getCategoryShortName('Miscellaneous'), 'Miscellaneous'); // passthrough
    });
  });

  // ─── Episode Model ─────────────────────────────────────────────────────

  group('Episode model', () {
    test('default description is empty', () {
      const ep = Episode(title: 'Test', url: 'http://x', category: 'Cat');
      expect(ep.description, '');
    });
  });
}
