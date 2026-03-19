import '../utils/constants.dart';

class TrackingService {
  double _sessionValidTime = 0;
  double _lastTimeUpdate = 0;
  bool _hasCreditedSession = false;

  double get sessionValidTime => _sessionValidTime;
  bool get hasCreditedSession => _hasCreditedSession;

  void reset() {
    _sessionValidTime = 0;
    _lastTimeUpdate = 0;
    _hasCreditedSession = false;
  }

  void update(double currentTime, {required bool isPaused, required bool isDragging}) {
    if (_lastTimeUpdate > 0 && !isPaused && !isDragging) {
      final delta = currentTime - _lastTimeUpdate;
      // Relaxed delta (3s) to account for background throttles on mobile
      if (delta > 0 && delta < maxDeltaSeconds) {
        _sessionValidTime += delta;
      }
    }
    _lastTimeUpdate = currentTime;
  }

  /// Returns true if badge threshold reached and not yet credited this session
  bool checkCompletion(double duration) {
    if (duration > 0 && !_hasCreditedSession) {
      if (_sessionValidTime > duration * badgeThreshold) {
        _hasCreditedSession = true;
        return true;
      }
    }
    return false;
  }
}
