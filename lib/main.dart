import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data/episodes_data.dart';
import 'providers/app_state_provider.dart';
import 'providers/audio_provider.dart';
import 'providers/library_provider.dart';
import 'services/audio_service.dart';
import 'services/storage_service.dart';
import 'services/firebase_sync_service.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();

  // Initialize Firebase + sync (non-blocking — app still works if it fails)
  FirebaseSyncService? firebaseSync;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseSync = FirebaseSyncService();
    await firebaseSync.init();
    storageService.setFirebaseSync(firebaseSync);
  } catch (e) {
    debugPrint('Firebase init failed — continuing with local-only storage: $e');
  }

  // Load local state, then merge with cloud (safe if Firebase failed)
  final appStateProvider = AppStateProvider(storageService);
  try {
    await appStateProvider.mergeWithCloud();
  } catch (e) {
    debugPrint('Cloud merge failed: $e');
  }

  final audioService = AppAudioService();

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider<FirebaseSyncService>.value(
          value: firebaseSync ?? FirebaseSyncService.disabled(),
        ),
        ChangeNotifierProvider<AppStateProvider>.value(value: appStateProvider),
        ChangeNotifierProvider<AudioProvider>(
          create: (_) =>
              AudioProvider(audioService, appStateProvider, allEpisodes),
        ),
        ChangeNotifierProvider<LibraryProvider>(
          create: (_) => LibraryProvider(allEpisodes),
        ),
      ],
      child: const MidnightBoardReviewApp(),
    ),
  );
}

class MidnightBoardReviewApp extends StatelessWidget {
  const MidnightBoardReviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            final epParam = state.uri.queryParameters['ep'];
            final tParam = state.uri.queryParameters['t'];
            final ep = epParam != null ? int.tryParse(epParam) : null;
            final t = tParam != null ? double.tryParse(tParam) : null;

            // Bounds check (fixes original JS issue)
            final validEp =
                ep != null && ep >= 0 && ep < allEpisodes.length ? ep : null;

            return HomeScreen(
              initialEpisode: validEp,
              initialTime: t,
            );
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Midnight Board Review',
      theme: buildAppTheme(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
