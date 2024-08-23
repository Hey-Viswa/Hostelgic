import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.size,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          color: color,
          child: isSquare ? null : Icon(Icons.circle, size: size, color: color),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: size, // Ensure font size is readable
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
