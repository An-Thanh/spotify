import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_img.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/routes/app_route.dart';

class SignInSignUp extends StatelessWidget {
  const SignInSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            const BasicAppbar(),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(AppVectors.topPattern)),
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(AppVectors.bottomPattern)),
            Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(AppImg.signin_signup_background)),
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppVectors.spotifyText),
                    const SizedBox(height: 51),
                    Text(
                      'Enjoy Listening To Music',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode ? AppColors.white : AppColors.black,
                          fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 21),
                    const Text(
                      'Spotify is a proprietary Swedish audio\n streaming and media services provider ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyDark,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: BasicAppButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.sighUpPage);
                              },
                              text: 'Register',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.sighInPage);
                                  // Handle sign in button press
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.isDarkMode ? AppColors.white : AppColors.black, 
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
