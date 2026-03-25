import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_state.dart';
import '../utils/constants.dart';
import 'firebase_sync_service.dart';

class StorageService {
  late SharedPreferences _prefs;
  FirebaseSyncService? _firebaseSync;

  void setFirebaseSync(FirebaseSyncService sync) {
    _firebaseSync = sync;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  PersistedState load() {
    final raw = _prefs.getString(storageKey);
    if (raw != null) {
      return PersistedState.decode(raw);
    }
    return PersistedState();
  }

  /// Load local state and merge with cloud state.
  Future<PersistedState> loadAndMerge() async {
    final local = load();
    if (_firebaseSync == null || !_firebaseSync!.isInitialized) return local;

    final cloud = await _firebaseSync!.pullState();
    if (cloud == null) return local;

    final merged = FirebaseSyncService.mergeStates(local, cloud);
    // Save merged state to both local and cloud
    await save(merged, pushToCloud: false);
    await _firebaseSync!.pushState(merged);
    return merged;
  }

  Future<void> save(PersistedState state, {bool pushToCloud = true}) async {
    await _prefs.setString(storageKey, state.encode());
    if (pushToCloud && _firebaseSync != null) {
      _firebaseSync!.pushStateDebounced(state);
    }
  }

  /// Immediate push to cloud (for high-value events like badge completion).
  Future<void> saveImmediate(PersistedState state) async {
    await _prefs.setString(storageKey, state.encode());
    if (_firebaseSync != null) {
      await _firebaseSync!.pushState(state);
    }
  }

  bool hasSeenInfo() => _prefs.getBool(infoSeenKey) ?? false;

  Future<void> markInfoSeen() async {
    await _prefs.setBool(infoSeenKey, true);
  }

  bool isBockenekMode() => _prefs.getBool(bockenekModeKey) ?? false;

  Future<void> setBockenekMode(bool value) async {
    await _prefs.setBool(bockenekModeKey, value);
  }
}
