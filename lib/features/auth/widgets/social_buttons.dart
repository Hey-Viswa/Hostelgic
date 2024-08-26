import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String text;
  final String assetName;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final BorderSide borderSide;
  final double borderRadius;
  final double elevation;
  final double iconSize;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.assetName,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderSide = const BorderSide(color: Colors.grey),
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: borderSide,
        elevation: elevation,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            assetName,
            height: iconSize,
            width: iconSize,
          ),
          const SizedBox(width: 12.0),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
