import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_state.dart';

class FirebaseSyncService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Timer? _debounceTimer;
  bool _initialized = false;

  User? get user => _auth.currentUser;
  bool get isSignedInWithGoogle =>
      user != null &&
      user!.providerData.any((p) => p.providerId == 'google.com');
  String? get userEmail =>
      isSignedInWithGoogle ? user!.providerData.firstWhere((p) => p.providerId == 'google.com').email : null;
  bool get isInitialized => _initialized;

  /// Initialize: sign in anonymously if not already signed in.
  Future<void> init() async {
    try {
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
      }
      _initialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('FirebaseSync init error: $e');
      // App still works with local-only storage
    }
  }

  /// Sign in with Google, linking to existing anonymous account.
  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false; // User cancelled

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // If currently anonymous, link the Google credential
      if (user != null && user!.isAnonymous) {
        try {
          await user!.linkWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'credential-already-in-use') {
            // Google account already linked to another user.
            // Sign in directly — merge data manually.
            await _auth.signInWithCredential(credential);
          } else {
            rethrow;
          }
        }
      } else {
        await _auth.signInWithCredential(credential);
      }

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      return false;
    }
  }

  /// Sign out (reverts to anonymous).
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      // Sign in anonymously again so cloud backup continues
      await _auth.signInAnonymously();
      notifyListeners();
    } catch (e) {
      debugPrint('Sign out error: $e');
    }
  }

  /// Push state to Firestore (debounced — waits 10s after last call).
  void pushStateDebounced(PersistedState state) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 10), () {
      pushState(state);
    });
  }

  /// Push state to Firestore immediately.
  Future<void> pushState(PersistedState state) async {
    if (!_initialized || user == null) return;
    try {
      await _db.collection('users').doc(user!.uid).set(
            state.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      debugPrint('Firestore push error: $e');
    }
  }

  /// Pull state from Firestore.
  Future<PersistedState?> pullState() async {
    if (!_initialized || user == null) return null;
    try {
      final doc = await _db.collection('users').doc(user!.uid).get();
      if (doc.exists && doc.data() != null) {
        return PersistedState.fromJson(doc.data()!);
      }
    } catch (e) {
      debugPrint('Firestore pull error: $e');
    }
    return null;
  }

  /// Merge local and cloud states. Returns the merged result.
  /// Strategy: max completion count, latest position per episode.
  static PersistedState mergeStates(PersistedState local, PersistedState cloud) {
    final merged = PersistedState(
      lastIndex: local.lastIndex, // Keep local as current session
      playbackSpeed: local.playbackSpeed,
      history: [...local.history],
    );

    // Merge positions: keep the larger value (further into the episode)
    final allPositionKeys = {...local.positions.keys, ...cloud.positions.keys};
    for (final key in allPositionKeys) {
      final localPos = local.positions[key] ?? 0;
      final cloudPos = cloud.positions[key] ?? 0;
      merged.positions[key] = localPos > cloudPos ? localPos : cloudPos;
    }

    // Merge durations: keep the larger value
    final allDurationKeys = {...local.durations.keys, ...cloud.durations.keys};
    for (final key in allDurationKeys) {
      final localDur = local.durations[key] ?? 0;
      final cloudDur = cloud.durations[key] ?? 0;
      merged.durations[key] = localDur > cloudDur ? localDur : cloudDur;
    }

    // Merge completions: keep the max count
    final allCompletionKeys = {
      ...local.completions.keys,
      ...cloud.completions.keys,
    };
    for (final key in allCompletionKeys) {
      final localCount = local.completions[key] ?? 0;
      final cloudCount = cloud.completions[key] ?? 0;
      merged.completions[key] = localCount > cloudCount ? localCount : cloudCount;
    }

    return merged;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
