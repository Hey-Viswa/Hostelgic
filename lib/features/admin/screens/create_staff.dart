import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_services/api_calls.dart';
import '../../../api_services/api_utils.dart';
import '../../../common/app_bar.dart';
import '../../../common/spacing.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';

class CreateStaff extends StatefulWidget {
  const CreateStaff({super.key});

  @override
  State<CreateStaff> createState() => _CreateStaffState();
}

class _CreateStaffState extends State<CreateStaff> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController jobRole = TextEditingController();
  ApiCall apiCall = ApiCall();

  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    jobRole.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Create Staff"),
      backgroundColor: AppColors.kBackgroundColor,
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text("You don't have permission to view this page"),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildSectionTitle('Personal Information'),
                    _buildTextFieldCard(
                      label: 'Username',
                      controller: userName,
                      hintText: 'Enter username',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildTextFieldCard(
                      label: 'First Name',
                      controller: firstName,
                      hintText: 'Enter first name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First Name is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildTextFieldCard(
                      label: 'Last Name',
                      controller: lastName,
                      hintText: 'Enter last name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Last Name is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildSectionTitle('Contact Information'),
                    _buildTextFieldCard(
                      label: 'Email',
                      controller: email,
                      hintText: 'Enter email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Invalid email address';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildTextFieldCard(
                      label: 'Phone Number',
                      controller: phoneNumber,
                      hintText: 'Enter phone number',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildSectionTitle('Job Information'),
                    _buildTextFieldCard(
                      label: 'Job Role',
                      controller: jobRole,
                      hintText: 'Enter job role',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Job Role is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(15),
                    _buildTextFieldCard(
                      label: 'Password',
                      controller: password,
                      hintText: 'Enter password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    heightSpacer(40),
                    CustomButton(
                      buttonText: "Create Staff",
                      press: () async {
                        if (_formKey.currentState!.validate()) {}
                      },
                      icon: Icons
                          .person_add_alt_1, // Adding an icon to the button
                      rounded: true, size: 16, // Make the button rounded
                    ),
                    heightSpacer(20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: AppTextTheme.kLabelStyle.copyWith(fontSize: 18.sp),
      ),
    );
  }

  Widget _buildTextFieldCard({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? hintText,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextTheme.kLabelStyle),
            heightSpacer(5),
            CustomTextField(
              controller: controller,
              validator: validator,
              inputHint: hintText ?? '',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffacb5bb)),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
