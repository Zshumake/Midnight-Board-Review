import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../models/episode.dart';
import '../services/audio_service.dart';
import '../services/tracking_service.dart';
import 'app_state_provider.dart';

class AudioProvider extends ChangeNotifier {
  final AppAudioService _audio;
  final AppStateProvider _appState;
  final TrackingService _tracking = TrackingService();
  final List<Episode> _episodes;

  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isLoading = false;
  bool _isDragging = false;
  String? _error;
  int _lastSavedSecond = -1;

  final List<StreamSubscription> _subs = [];

  AudioProvider(this._audio, this._appState, this._episodes) {
    _currentIndex = _appState.lastIndex.clamp(0, _episodes.length - 1);

    _subs.add(_audio.positionStream.listen((pos) {
      _position = pos;
      _onTimeUpdate();
      notifyListeners();
    }));

    _subs.add(_audio.durationStream.listen((dur) {
      if (dur != null) {
        _duration = dur;
        _appState.setDuration(
            currentEpisode.title, dur.inMilliseconds / 1000.0);
        notifyListeners();
      }
    }));

    _subs.add(_audio.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      if (state.processingState == ProcessingState.completed) {
        _onEpisodeComplete();
      }
      notifyListeners();
    }));
  }

  // Getters
  int get currentIndex => _currentIndex;
  Episode get currentEpisode => _episodes[_currentIndex];
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isLoading => _isLoading;
  bool get isDragging => _isDragging;
  String? get error => _error;
  List<Episode> get episodes => _episodes;

  Future<void> loadEpisode(int index, {bool autoPlay = true}) async {
    if (index < 0 || index >= _episodes.length) return;

    _isLoading = true;
    _error = null;
    _currentIndex = index;
    _appState.setLastIndex(index);
    _tracking.reset();
    _lastSavedSecond = -1;
    notifyListeners();

    try {
      final episode = _episodes[index];
      await _audio.load(episode.url);

      // Restore saved position (if >95% done, restart from 0)
      final savedPos = _appState.getPosition(episode.title);
      final dur = _audio.duration?.inMilliseconds.toDouble() ?? 0;
      if (savedPos > 0 && dur > 0 && savedPos / (dur / 1000) < 0.95) {
        await _audio.seek(Duration(seconds: savedPos.toInt()));
      }

      // Apply saved speed
      await _audio.setSpeed(_appState.playbackSpeed);

      _isSourceLoaded = true;
      if (autoPlay) await _audio.play();
    } catch (e) {
      _error = 'Failed to load episode: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _isSourceLoaded = false;

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _audio.pause();
    } else if (!_isSourceLoaded) {
      // First launch — no audio loaded yet, load the current episode
      await loadEpisode(_currentIndex);
    } else {
      await _audio.play();
    }
  }

  Future<void> seekTo(Duration position) async {
    await _audio.seek(position);
    _tracking.update(
      position.inMilliseconds / 1000.0,
      isPaused: !_isPlaying,
      isDragging: false,
    );
  }

  void setDragging(bool dragging) {
    _isDragging = dragging;
  }

  Future<void> skipForward() =>
      _audio.seekRelative(const Duration(seconds: 10));

  Future<void> skipBackward() =>
      _audio.seekRelative(const Duration(seconds: -10));

  Future<void> nextEpisode() async {
    if (_currentIndex < _episodes.length - 1) {
      await loadEpisode(_currentIndex + 1);
    }
  }

  Future<void> previousEpisode() async {
    // If more than 3 seconds in, restart current episode
    if (_position.inSeconds > 3) {
      await _audio.seek(Duration.zero);
    } else if (_currentIndex > 0) {
      await loadEpisode(_currentIndex - 1);
    } else {
      // On first episode within first 3 seconds — restart from beginning
      await _audio.seek(Duration.zero);
    }
  }

  Future<void> setSpeed(double speed) async {
    await _audio.setSpeed(speed);
    _appState.setSpeed(speed);
  }

  void _onTimeUpdate() {
    final currentSec = _position.inSeconds;
    final posSeconds = _position.inMilliseconds / 1000.0;

    // Track listening for badge validation
    _tracking.update(
      posSeconds,
      isPaused: !_isPlaying,
      isDragging: _isDragging,
    );

    // Save position every second (not every frame)
    if (currentSec != _lastSavedSecond) {
      _lastSavedSecond = currentSec;
      _appState.setPosition(currentEpisode.title, posSeconds);
    }

    // Check badge completion
    final durSeconds = _duration.inMilliseconds / 1000.0;
    if (_tracking.checkCompletion(durSeconds)) {
      _appState.incrementCompletion(currentEpisode.title);
    }
  }

  void _onEpisodeComplete() {
    // Auto-next
    if (_currentIndex < _episodes.length - 1) {
      loadEpisode(_currentIndex + 1);
    }
  }

  @override
  void dispose() {
    for (final sub in _subs) {
      sub.cancel();
    }
    _audio.dispose();
    super.dispose();
  }
}
