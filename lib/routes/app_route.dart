import 'package:flutter/material.dart';
import 'package:spotify_clone/features/auth/presentations/screens/signin.dart';
import 'package:spotify_clone/features/auth/presentations/screens/sighup.dart';
import 'package:spotify_clone/features/get_started/presentation/screens/get_started_page.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';
import 'package:spotify_clone/features/home_page/presentations/screens/home.dart';
import 'package:spotify_clone/features/main_page/presentations/screens/mainpage.dart';
import 'package:spotify_clone/features/song_player/presentations/screens/song_player.dart';



class AppRoutes {
  // Khai báo tên các route dưới dạng hằng số
  static const String started_page = '/started_page';
  static const String sighUpPage = '/sighUpPage';
  static const String sighInPage = '/sighInPage';
  static const String homePage = '/homePage';
  static const String mainPage = '/mainPage';
  static const String displayed_song = '/displayed_song';
  // onGenerateRoute dùng để định nghĩa các route động
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case displayed_song:
        final args = settings.arguments as SongEntity;
        return MaterialPageRoute(
          builder: (context) => SongPlayer(displayed_song: args, isnewSong: true),
        );
      // case fourPage:
      //   final args = settings.arguments as int;
      //   return MaterialPageRoute(
      //     builder: (context) => FourPage(count: args),
      //   );
      default:
        // return MaterialPageRoute(
        //   builder: (context) => const HomePage(), // Fallback route
        // );
    }
    return null;
  }

  // Khai báo các route tĩnh
  static Map<String, WidgetBuilder> routes = {
    started_page: (context) => const GetStartedPage(),
    sighUpPage: (context) => Sighup(),
    sighInPage: (context) => const SighIn(),
    homePage: (context) => const HomePage(),
    mainPage: (context) => const NavBottomBar()
  };
}
