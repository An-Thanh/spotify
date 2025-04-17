
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/core/configs/theme/app_theme.dart';
import 'package:spotify_clone/core/spotify_api/search.dart';
import 'package:spotify_clone/core/ultils/toast_util.dart';
import 'package:spotify_clone/database/local_db/database_helper.dart';
import 'package:spotify_clone/features/choose_mode/presentation/bloc/theme_cubit.dart';
import 'package:spotify_clone/features/main_page/presentations/cubit/page_cubit.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_cubit.dart';
import 'package:spotify_clone/features/splash/presentation/screens/splash.dart';
import 'package:spotify_clone/firebase_options.dart';
import 'package:spotify_clone/routes/app_route.dart';
import 'package:spotify_clone/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.spotify_clone.audio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
      androidNotificationClickStartsActivity: true,
      androidShowNotificationBadge: false,
    );
  await DatabaseHelper().database;
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastUtil.ensureInitialized();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SongPlayerCubit()),
        BlocProvider(create: (_) => PageCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
              themeMode: state,
              builder: FToastBuilder(),
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              routes: AppRoutes.routes,
              onGenerateRoute: (settings) =>
                  AppRoutes.onGenerateRoute(settings),
              title: 'Spotify Demo',
              theme: AppTheme.lightTheme,
              home: const SplashPage());
        },
      ),
    );
  }
}
