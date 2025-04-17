import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/widgets/basic_app_button.dart';
import 'package:spotify_clone/common/widgets/custom_textfield.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/core/ultils/toast_util.dart';
import 'package:spotify_clone/features/auth/data/models/signin_user_req.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signin_usecase.dart';
import 'package:spotify_clone/routes/app_route.dart';
import 'package:spotify_clone/service_locator.dart';

class SighIn extends StatefulWidget {
  const SighIn({super.key});

  @override
  State<SighIn> createState() => _SighInState();
}

class _SighInState extends State<SighIn> {
  String email = "";
  String password = "";
  @override
  void initState() {
    super.initState();
    ToastUtil.ensureInitialized();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _sighupText(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset(
          AppVectors.logo_mini,
          height: 35,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sighinText(),
              _helpText(),
              const SizedBox(height: 50),
              CustomTextfield(
                hintText: "Enter Email",
                onChanged: (value) {
                  // Handle name change
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintText: "Password",
                onChanged: (value) {
                  // Handle password change
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              BasicAppButton(
                  height: 90,
                  onPressed: () async {
                    // Handle register button press
                    if (email.isNotEmpty && password.isNotEmpty) {
                      email = email.trim();
                      password = password.trim();
                      if (password.length < 6) {
                        ToastUtil.showErrorToast(
                          "Password must be at least 6 characters",
                          title: 'Error',
                        );
                        return;
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(email)) {
                        ToastUtil.showErrorToast(
                          "Please enter a valid email",
                          title: 'Error',
                        );
                        return;
                      }
                      // Perform sign-in action here
                      var result = await sl<SighinUsecase>().call(
                        params: SigninUserReq(
                          email: email.trim(),
                          password: password.trim(),
                        ),
                      );
                      result.fold(
                        (error) {
                          ToastUtil.showErrorToast(
                            error.toString(),
                            title: 'Error',
                          );
                        },
                        (success) {
                          ToastUtil.showSuccessToast(
                            success.toString(),
                            title: "Success",
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.mainPage,
                          );
                        },
                      );
                    } else {
                      ToastUtil.showErrorToast(
                        "Please fill all fields",
                        title: "Error",
                      );
                    }
                  },
                  text: "Sign In")
            ],
          ),
        ),
      ),
    );
  }

  Widget _sighinText() {
    return const Text(
      'Sigh In',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _helpText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'If You Need Any Support',
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              // Handle register button press
            },
            child: const Text(
              'Click Here',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sighupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not a Member ? ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.sighUpPage);
            },
            child: const Text(
              'Register Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
