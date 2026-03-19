import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_state.dart';
import '../utils/constants.dart';

class StorageService {
  late SharedPreferences _prefs;

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

  Future<void> save(PersistedState state) async {
    await _prefs.setString(storageKey, state.encode());
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
