import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'data/episodes_data.dart';
import 'providers/app_state_provider.dart';
import 'providers/audio_provider.dart';
import 'providers/library_provider.dart';
import 'services/audio_service.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();

  final appStateProvider = AppStateProvider(storageService);
  final audioService = AppAudioService();

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
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
