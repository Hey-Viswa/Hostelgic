import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/LoginScreen.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_text_field.dart';
import 'package:youtube_tutorial_hostel_management/theme/colors.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  ApiCall apiCall = ApiCall();
  String? validationMessage;

  String? selectedBlock;
  String? selectedRoom;
  bool _isPasswordVisible = false;

  final List<String> blockOptions = ['A', 'B'];
  final List<String> roomOptionsA = ['101', '102', '103', '104'];
  final List<String> roomOptionsB = ['201', '202', '203', '204'];

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
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
              height: 219.h, // Adjust height here
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
                    alignment: Alignment.topLeft,
                    child: BackButton(
                      color: Color(0xffffffff),
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
                            "Register",
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
                                "Already have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  " Login",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.kBlueColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpacer(56),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "First Name",
                                      style: AppTextTheme.kLabelStyle.copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.authGrey),
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: firstName,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                            color: Color(0xffacb5bb))),
                                    inputHint: "First Name",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "First Name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Last Name",
                                      style: AppTextTheme.kLabelStyle.copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.authGrey),
                                    ),
                                  ),
                                  CustomTextField(
                                    controller: lastName,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                            color: Color(0xffacb5bb))),
                                    inputHint: "Last Name",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Last Name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        heightSpacer(16),
                        CustomTextField(
                          controller: userName,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(color: Color(0xffacb5bb))),
                          inputHint: "Username",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        heightSpacer(16),
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
                        CustomTextField(
                          controller: phoneNumber,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(color: Color(0xffacb5bb))),
                          inputHint: "Phone Number",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
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
