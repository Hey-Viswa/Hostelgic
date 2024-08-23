import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Function() press;
  final double? size;

  const CustomButton(
      {super.key,
      required this.buttonText,
      this.buttonColor,
      required this.press,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.maxFinite,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.kBlueColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextTheme.kLabelStyle.copyWith(
              color: buttonColor ?? AppColors.kLight,
              fontSize: size ?? 16,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSignInButton extends StatelessWidget {
  final String text;
  final String assetName;
  final VoidCallback onPressed;
  final double borderRadius;
  final double elevation;
  final double padding;
  final Color backgroundColor;
  final Color textColor;
  final BorderSide borderSide;

  const CustomSignInButton({
    required this.text,
    required this.assetName,
    required this.onPressed,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.padding = 4.0,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderSide = const BorderSide(color: Colors.grey),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        side: borderSide,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: padding, horizontal: padding),
            child: Image.asset(
              assetName,
              height: 24,
              width: 24,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
