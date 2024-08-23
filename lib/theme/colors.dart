import 'package:flutter/material.dart';

LinearGradient linearColor() {
  return LinearGradient(
    colors: AppColors.colors,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: const [0.4, 0.7],
    tileMode: TileMode.repeated,
  );
}

LinearGradient backgroundLinearColor() {
  return const LinearGradient(
    colors: [Color(0xffF4FDFF), Color(0xffD7E0FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.4, 0.7],
    tileMode: TileMode.repeated,
  );
}

class AppColors {
  AppColors._();

  static const Color kPrimaryColor = Color(0xFF11212E);
  static const Color kBlueColor = Color(0xff3572ea);
  static const Color kLightBlue = Color(0xFF6DA7FF);
  static const Color kSecondaryColor = Color(0xFF0B2C47);
  static const Color kBackgroundColor = Colors.white;
  static const Color kFormLabelColor = kBlueColor;
  static const Color kLight = Color(0xffffffff);
  static const Color kGreyDk = Color(0xff9091AD);
  static const Color authGrey = Color(0xff6C7278);
  static const Color kAppBarColor = Color(0XFF0B2C47);
  static const Color kRewardBackgroundColor = Color(0xFF18122B);
  static const Color kButtonColor = Color(0xF1F1F1F1);
  static const Color keventCardColor = Color(0xFFF1F3FF);
  static const Color kchatBackgroundColor = Color(0xFFF1F3FF);
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  static List<Color> colors = [
    const Color(0xff3765DD),
    const Color(0xff7464D2)
  ];
  static List<Color> winnerBackgroundColors = [
    const Color(0xff6C00FF),
    const Color(0xff7147E5),
  ];
}
