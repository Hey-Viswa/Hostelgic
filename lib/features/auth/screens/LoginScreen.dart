import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelgic/features/auth/screens/register_screen.dart';
import 'package:hostelgic/features/auth/widgets/social_buttons.dart';

import '../../../api_services/api_calls.dart';
import '../../../common/constants.dart';
import '../../../common/spacing.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  static final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  ApiCall apiCall = ApiCall();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 263.h, // Adjust height here
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.header),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28.h),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Image(
                        image: AssetImage(AppConstants.logo),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h), // Adjust to match the image height
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sign in to Your Account",
                            style: TextStyle(
                                fontSize: 32.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        heightSpacer(12),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  " Sign Up",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.kBlueColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpacer(56),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 14.sp, color: AppColors.authGrey),
                          ),
                        ),
                        CustomTextField(
                          controller: email,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(color: Color(0xffacb5bb))),
                          inputHint: "Email",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                        heightSpacer(16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 14.sp, color: AppColors.authGrey),
                          ),
                        ),
                        CustomTextField(
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off_sharp,
                              color: const Color(0xFFAAB3B9), // Updated color
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          controller: password,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(color: Color(0xffacb5bb))),
                          inputHint: "Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                        heightSpacer(16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password ?",
                            style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 14.sp, color: AppColors.kBlueColor),
                          ),
                        ),
                        heightSpacer(32),
                        CustomButton(
                          buttonText: "Login",
                          buttonColor: AppColors.kBlueColor,
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              await apiCall.handleLogin(
                                  context, email.text, password.text);
                              print('validated');
                            }
                          },
                          size: 16,
                        ),
                        heightSpacer(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xffedf1f3),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Or login with",
                                style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: const Color(0xff757b80)),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Color(0xffedf1f3),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        heightSpacer(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SocialSignInButton(
                                text: 'Google',
                                assetName: 'assets/google.png',
                                onPressed: () {},
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: SocialSignInButton(
                                text: 'Facebook',
                                assetName: 'assets/facebook.png',
                                onPressed: () {},
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
