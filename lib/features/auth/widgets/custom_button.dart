import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Function() press;
  final double? size;
  final IconData? icon; // Adding an icon parameter
  final bool rounded; // Adding a rounded parameter

  const CustomButton({
    super.key,
    required this.buttonText,
    this.buttonColor,
    required this.press,
    required this.size,
    this.icon, // Initializing the icon parameter
    this.rounded = false, // Default value for rounded is false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.maxFinite,
        height: 50.h,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.kBlueColor,
          borderRadius: BorderRadius.circular(
              rounded ? 25.r : 14.r), // Adjusted based on rounded parameter
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: buttonColor ?? AppColors.kLight,
                size: 24.w,
              ),
            if (icon != null) SizedBox(width: 10.w),
            Text(
              buttonText,
              style: AppTextTheme.kLabelStyle.copyWith(
                color: const Color(0xffffffff),
                fontSize: size ?? 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
