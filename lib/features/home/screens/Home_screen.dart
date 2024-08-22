import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_tutorial_hostel_management/common/constants.dart';
import 'package:youtube_tutorial_hostel_management/theme/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle.copyWith(fontSize: 22.sp),
        ),
        actions: [SvgPicture.asset(AppConstants.profile)],
      ),
    );
  }
}
