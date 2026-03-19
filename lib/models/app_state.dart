import 'dart:convert';

class PersistedState {
  int lastIndex;
  Map<String, double> positions;
  Map<String, double> durations;
  Map<String, int> completions;
  List<String> history; // Legacy, kept for migration
  double playbackSpeed;

  PersistedState({
    this.lastIndex = 0,
    Map<String, double>? positions,
    Map<String, double>? durations,
    Map<String, int>? completions,
    List<String>? history,
    this.playbackSpeed = 1.0,
  })  : positions = positions ?? {},
        durations = durations ?? {},
        completions = completions ?? {},
        history = history ?? [];

  factory PersistedState.fromJson(Map<String, dynamic> json) {
    final state = PersistedState(
      lastIndex: (json['lastIndex'] as num?)?.toInt() ?? 0,
      positions: _toDoubleMap(json['positions']),
      durations: _toDoubleMap(json['durations']),
      completions: _toIntMap(json['completions']),
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      playbackSpeed: (json['playbackSpeed'] as num?)?.toDouble() ?? 1.0,
    );

    // Migration: sync history to completions (same as JS state.js)
    for (final title in state.history) {
      if (!state.completions.containsKey(title)) {
        state.completions[title] = 1;
      }
    }

    return state;
  }

  Map<String, dynamic> toJson() => {
        'lastIndex': lastIndex,
        'positions': positions,
        'durations': durations,
        'completions': completions,
        'history': history,
        'playbackSpeed': playbackSpeed,
      };

  String encode() => jsonEncode(toJson());

  static PersistedState decode(String source) {
    try {
      return PersistedState.fromJson(
          jsonDecode(source) as Map<String, dynamic>);
    } catch (_) {
      return PersistedState();
    }
  }

  static Map<String, double> _toDoubleMap(dynamic value) {
    if (value is! Map) return {};
    return value.map((k, v) => MapEntry(k.toString(), (v as num).toDouble()));
  }

  static Map<String, int> _toIntMap(dynamic value) {
    if (value is! Map) return {};
    return value.map((k, v) => MapEntry(k.toString(), (v as num).toInt()));
  }
}
