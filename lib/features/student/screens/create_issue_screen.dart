import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_services/api_calls.dart';
import '../../../common/app_bar.dart';
import '../../../common/spacing.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../../auth/widgets/custom_button.dart';
import '../../auth/widgets/custom_text_field.dart';

class CreateIssueScreen extends StatefulWidget {
  const CreateIssueScreen({super.key});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController roomNumber = TextEditingController();
  final TextEditingController block = TextEditingController();
  final TextEditingController studentComment = TextEditingController();
  final TextEditingController studentEmailId = TextEditingController();
  final TextEditingController studentContactNumber = TextEditingController();
  final ApiCall apiCall = ApiCall();

  String? selectedIssue;
  final List<String> issues = [
    'Bathroom',
    'Bedroom',
    'Water',
    'Furniture',
    'Kitchen',
  ];

  @override
  void dispose() {
    roomNumber.dispose();
    block.dispose();
    studentComment.dispose();
    studentEmailId.dispose();
    studentContactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets commonPadding = EdgeInsets.all(20);

    return Scaffold(
      appBar: buildAppBar(context, "Create Issue"),
      backgroundColor: AppColors.kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle('Issue Details', commonPadding),
              _buildTextFieldCard(
                label: 'Room Number',
                controller: roomNumber,
                hintText: 'Enter your room number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Room Number is required';
                  }
                  return null;
                },
                padding: commonPadding,
              ),
              heightSpacer(15),
              _buildTextFieldCard(
                label: 'Block Number',
                controller: block,
                hintText: 'Enter your block number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Block Number is required';
                  }
                  return null;
                },
                padding: commonPadding,
              ),
              heightSpacer(15),
              _buildSectionTitle('Contact Information', commonPadding),
              _buildTextFieldCard(
                label: 'Your Email ID',
                controller: studentEmailId,
                hintText: 'Enter your email ID',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email ID is required';
                  }
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                padding: commonPadding,
              ),
              heightSpacer(15),
              _buildTextFieldCard(
                label: 'Phone Number',
                controller: studentContactNumber,
                hintText: 'Enter your phone number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                padding: commonPadding,
              ),
              heightSpacer(15),
              _buildSectionTitle('Issue Information', commonPadding),
              _buildIssueInfoCard(padding: commonPadding, label: "Issue"),
              heightSpacer(15),
              _buildTextFieldCard(
                label: 'Comments',
                controller: studentComment,
                hintText: 'Enter your comments',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Comments are required';
                  }
                  return null;
                },
                padding: commonPadding,
              ),
              heightSpacer(40),
              CustomButton(
                buttonText: "Submit",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                  }
                },
                buttonColor: AppColors.kBlueColor,
                size: 16.sp,
              ),
              heightSpacer(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, EdgeInsets padding) {
    return Text(
      title,
      style: AppTextTheme.kLabelStyle,
    );
  }

  Widget _buildIssueInfoCard({
    required EdgeInsets padding,
    required String label,
  }) {
    return Card(
      color: AppColors.contentColorWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextTheme.kLabelStyle),
            heightSpacer(5),
            _buildDropdownField(padding),
            heightSpacer(15),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(EdgeInsets padding) {
    return Container(
      padding: padding.copyWith(top: 0.h, bottom: 0.h),
      decoration: ShapeDecoration(
        color: AppColors.contentColorWhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.kBlueColor),
          borderRadius: BorderRadius.circular(14),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButton<String>(
        underline: Container(),
        isExpanded: true,
        value: selectedIssue,
        onChanged: (String? newValue) {
          setState(() {
            selectedIssue = newValue;
          });
        },
        items: issues.map((String issue) {
          return DropdownMenuItem<String>(
            value: issue,
            child: Text(
              issue,
              style: TextStyle(
                color: AppColors.authGrey,
                fontSize: 14.sp,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextFieldCard({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    EdgeInsets? padding,
    String? hintText,
    int maxLines = 1,
  }) {
    return Card(
      color: AppColors.contentColorWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
              maxLines: maxLines,
            ),
          ],
        ),
      ),
    );
  }

  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
