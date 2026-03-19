import 'package:just_audio/just_audio.dart';

class AppAudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<bool> get playingStream => _player.playingStream;

  Duration get position => _player.position;
  Duration? get duration => _player.duration;
  bool get playing => _player.playing;

  Future<void> load(String url) async {
    await _player.setUrl(url).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw Exception('Audio load timed out'),
        );
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  Future<void> seekRelative(Duration offset) {
    final newPos = _player.position + offset;
    final dur = _player.duration ?? Duration.zero;
    final clamped = newPos < Duration.zero
        ? Duration.zero
        : (newPos > dur ? dur : newPos);
    return _player.seek(clamped);
  }

  Future<void> dispose() => _player.dispose();
}
