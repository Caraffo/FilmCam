import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/diagnostics/frame_stats_logger.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/motion.dart';
import 'features/camera/presentation/screens/camera_screen.dart';
import 'features/settings/data/settings_repository.dart';
import 'features/settings/presentation/settings_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FrameStatsLogger.start();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final settings = await SettingsRepository.load();
  runApp(
    ProviderScope(
      overrides: [settingsRepositoryProvider.overrideWithValue(settings)],
      child: const FilmCamApp(),
    ),
  );
}

class FilmCamApp extends StatelessWidget {
  const FilmCamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmCam',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      builder: (context, child) {
        Motion.reduced = MediaQuery.disableAnimationsOf(context);
        return child!;
      },
      home: const CameraScreen(),
    );
  }
}
