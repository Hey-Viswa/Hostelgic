import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelgic/features/auth/screens/LoginScreen.dart';

import '../../../api_services/api_calls.dart';
import '../../../common/constants.dart';
import '../../../common/spacing.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  final String roomNumber;
  final String blockNumber;
  final String username;
  final String emailId;
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const ProfileScreen({
    super.key,
    required this.roomNumber,
    required this.blockNumber,
    required this.username,
    required this.emailId,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController roomNumber = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  ApiCall apiCall = ApiCall();

  @override
  void dispose() {
    super.dispose();
    roomNumber.dispose();
    phoneNumber.dispose();
    block.dispose();
    emailId.dispose();
    username.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlueColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Profile",
          style: AppTextTheme.kLabelStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00A86B), Color(0xFF00796B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage(AppConstants.profile),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () {
                          // Handle profile picture edit
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            heightSpacer(20),
            Text(
              '${widget.firstName} ${widget.lastName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            heightSpacer(10),
            Text(
              widget.emailId,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            heightSpacer(30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Room No.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.sp,
                                ),
                              ),
                              heightSpacer(5),
                              Text(
                                widget.roomNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        widthSpacer(20),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Block No.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16.sp,
                                ),
                              ),
                              heightSpacer(5),
                              Text(
                                widget.blockNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    heightSpacer(30),
                    CustomTextField(
                      controller: username,
                      inputHint: widget.username,
                      prefixIcon: const Icon(Icons.person_2_outlined),
                    ),
                    heightSpacer(20),
                    CustomTextField(
                      controller: phoneNumber,
                      inputHint: widget.phoneNumber,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    heightSpacer(20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstName,
                            inputHint: widget.firstName,
                          ),
                        ),
                        widthSpacer(20),
                        Expanded(
                          child: CustomTextField(
                            controller: lastName,
                            inputHint: widget.lastName,
                          ),
                        ),
                      ],
                    ),
                    heightSpacer(30),
                    CustomButton(
                      press: () {
                        apiCall.updateProfile(
                          context,
                          username.text,
                          firstName.text,
                          lastName.text,
                          phoneNumber.text,
                        );
                      },
                      buttonText: 'Save',
                      buttonColor: AppColors.kBlueColor,
                      size: null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
