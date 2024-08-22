import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_tutorial_hostel_management/api_services/api_calls.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/common/spacing.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/screens/LoginScreen.dart';
import 'package:youtube_tutorial_hostel_management/features/auth/widgets/custom_text_field.dart';
import 'package:youtube_tutorial_hostel_management/features/home/screens/Home_screen.dart';
import 'package:youtube_tutorial_hostel_management/theme/colors.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

import '../widgets/custom_button.dart';

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

  final List<String> blockOptions = [
    'A',
    'B',
  ];
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 219.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppConstants.header),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
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
                        SizedBox(height: 12.h),
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
                                    fontWeight: FontWeight.w700,
                                  ),
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
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        " Login",
                                        style:
                                            AppTextTheme.kLabelStyle.copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.kBlueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              heightSpacer(56),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "First Name",
                                          style:
                                              AppTextTheme.kLabelStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.authGrey,
                                          ),
                                        ),
                                        CustomTextField(
                                          controller: firstName,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                                color: Color(0xffacb5bb)),
                                          ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Last Name",
                                          style:
                                              AppTextTheme.kLabelStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.authGrey,
                                          ),
                                        ),
                                        CustomTextField(
                                          controller: lastName,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                                color: Color(0xffacb5bb)),
                                          ),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Block No.",
                                          style:
                                              AppTextTheme.kLabelStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.authGrey,
                                          ),
                                        ),
                                        Container(
                                          height: 50.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xffacb5bb)),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    selectedBlock ??
                                                        'Select Block',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextTheme
                                                        .kLabelStyle
                                                        .copyWith(
                                                      fontSize: 14.sp,
                                                      color: const Color(
                                                          0xffacb5bb),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DropdownButton<String>(
                                                value: selectedBlock,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedBlock = newValue;
                                                    selectedRoom = null;
                                                  });
                                                },
                                                items: blockOptions
                                                    .map((String block) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: block,
                                                    child: Text(block),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Room No.",
                                          style:
                                              AppTextTheme.kLabelStyle.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.authGrey,
                                          ),
                                        ),
                                        Container(
                                          height: 50.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 1,
                                                  color:
                                                      const Color(0xffacb5bb)),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                    selectedRoom ??
                                                        'Select Room',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextTheme
                                                        .kLabelStyle
                                                        .copyWith(
                                                      fontSize: 14.sp,
                                                      color: const Color(
                                                          0xffacb5bb),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DropdownButton<String>(
                                                value: selectedRoom,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedRoom = newValue;
                                                  });
                                                },
                                                items: (selectedBlock == 'A'
                                                        ? roomOptionsA
                                                        : roomOptionsB)
                                                    .map((String room) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: room,
                                                    child: Text(room),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              heightSpacer(16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Username",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.authGrey,
                                  ),
                                ),
                              ),
                              CustomTextField(
                                controller: userName,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xffacb5bb),
                                  ),
                                ),
                                inputHint: "Username",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Username is required";
                                  }
                                  return null;
                                },
                              ),
                              heightSpacer(16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.authGrey,
                                  ),
                                ),
                              ),
                              CustomTextField(
                                controller: email,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xffacb5bb)),
                                ),
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
                                  "Phone Number",
                                  style: AppTextTheme.kLabelStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.authGrey,
                                  ),
                                ),
                              ),
                              CustomTextField(
                                controller: phoneNumber,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Color(0xffacb5bb),
                                  ),
                                ),
                                inputHint: "Phone Number",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Number is required";
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
                                      fontSize: 14.sp,
                                      color: AppColors.authGrey),
                                ),
                              ),
                              CustomTextField(
                                obscureText: !_isPasswordVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_sharp
                                        : Icons.visibility_off_sharp,
                                    color: const Color(
                                        0xFFAAB3B9), // Updated color
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
                                    borderSide: const BorderSide(
                                        color: Color(0xffacb5bb))),
                                inputHint: "Password",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is required";
                                  }
                                  return null;
                                },
                              ),
                              heightSpacer(30),
                              CustomButton(
                                buttonText: "Register",
                                buttonColor: Colors.white,
                                press: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
