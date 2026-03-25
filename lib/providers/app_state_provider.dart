import 'package:flutter/foundation.dart';
import '../models/app_state.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

class AppStateProvider extends ChangeNotifier {
  final StorageService _storage;
  late PersistedState _state;

  AppStateProvider(this._storage) {
    _state = _storage.load();
  }

  int get lastIndex => _state.lastIndex;
  double get playbackSpeed => _state.playbackSpeed;

  void setLastIndex(int index) {
    if (_state.lastIndex != index) {
      _state.lastIndex = index;
      _save();
    }
  }

  double getPosition(String title) => _state.positions[title.trim()] ?? 0;

  void setPosition(String title, double position) {
    _state.positions[title.trim()] = position;
    _save();
  }

  double getDuration(String title) => _state.durations[title.trim()] ?? 0;

  void setDuration(String title, double duration) {
    if (duration > 0) {
      _state.durations[title.trim()] = duration;
      _save();
    }
  }

  double getProgressPercentage(String title) {
    final pos = getPosition(title);
    final dur = getDuration(title);
    if (dur > 0) return (pos / dur * 100).clamp(0, 100);
    if (getCompletionCount(title) > 0) return 100;
    return 0;
  }

  int getCompletionCount(String title) {
    final key = title.trim();
    final count = _state.completions[key] ?? 0;
    if (count == 0 && _state.history.contains(key)) return 1;
    return count;
  }

  /// Returns true if a new badge was awarded
  bool incrementCompletion(String title) {
    final key = title.trim();
    final current = _state.completions[key] ?? 0;
    if (current < maxBadges) {
      _state.completions[key] = current + 1;
      if (!_state.history.contains(key)) {
        _state.history.add(key);
      }
      _saveImmediate();
      notifyListeners();
      return true;
    }
    return false;
  }

  void resetCompletion(String title) {
    final key = title.trim();
    if (_state.completions.containsKey(key)) {
      _state.completions.remove(key);
      _state.history.remove(key);
      _save();
      notifyListeners();
    }
  }

  void setSpeed(double speed) {
    if (_state.playbackSpeed != speed) {
      _state.playbackSpeed = speed;
      _save();
      notifyListeners();
    }
  }

  /// Merge local state with cloud state on startup.
  Future<void> mergeWithCloud() async {
    _state = await _storage.loadAndMerge();
    notifyListeners();
  }

  void _save() {
    _storage.save(_state);
  }

  /// Immediate save for high-value events (badge completion).
  void _saveImmediate() {
    _storage.saveImmediate(_state);
  }
}
