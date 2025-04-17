import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/database/local_db/database_helper.dart';
import 'package:spotify_clone/routes/app_route.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: SvgPicture.asset(
            AppVectors.logo
          )
        ),
      ),
    );
  }

  Future<void> redirect() async{
    await Future.delayed(const Duration(seconds: 3));
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> existingUsers = await db.query('User');
    if (existingUsers.isEmpty) {
      Navigator.pushNamed(context, AppRoutes.started_page);
    }
    else{
      Navigator.pushNamed(context, AppRoutes.mainPage);
    }
  }
}