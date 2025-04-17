import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/widgets/basic_app_button.dart';
import 'package:spotify_clone/common/widgets/custom_textfield.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/ultils/toast_util.dart';
import 'package:spotify_clone/features/auth/data/models/create_user_req.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signup_usecase.dart';
import 'package:spotify_clone/routes/app_route.dart';
import 'package:spotify_clone/service_locator.dart';

class Sighup extends StatefulWidget {
  Sighup({super.key});

  @override
  State<Sighup> createState() => _SighupState();
}

class _SighupState extends State<Sighup> {
  String fullName = "";

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
      bottomNavigationBar: _sighinText(context),
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
          horizontal: 30,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50),
              CustomTextfield(
                hintText: "Full Name", 
                onChanged: (value) {
                  // Handle name change
                  setState(() {
                    fullName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                hintText: "Enter Email",
                onChanged: (value) {
                  // Handle email change
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
                  if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
                    fullName = fullName.trim();
                    email = email.trim();
                    password = password.trim();
                    // Show error message
                    ToastUtil.showErrorToast(
                      "Please fill all fields",
                      title: 'Error',
                    );
                    return;
                  }
                  if (password.length < 6) {
                    ToastUtil.showErrorToast(
                      "Password must be at least 6 characters",
                      title: 'Error',
                    );
                    return;
                  }
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
                    ToastUtil.showErrorToast(
                      "Please enter a valid email",
                      title: 'Error',
                    );
                    return;
                  }
                  if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(fullName)) {
                    ToastUtil.showErrorToast(
                      "Full name can only contain letters and numbers",
                      title: 'Error',
                    );
                    return;
                  }
                  // Handle register button press
                  var result = await sl<SighupUsecase>().call(
                    params: CreateUserReq(
                      fullName: fullName.trim(),
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
                        "Account created successfully, please sign in",
                        title: 'Success',
                      );
                      // Handle success
                      Navigator.pushReplacementNamed(context, AppRoutes.sighInPage);
                    },
                  );
                },
                text: "Create Account"
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _sighinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account? ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.sighInPage);
            },
            child: const Text(
              'Sign In',
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