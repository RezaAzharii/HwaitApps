import 'package:flutter/material.dart';

class AppColors {
  // Existing colors
  static const Color primary = Color(0xff4684e7);
  static const Color secondary = Color(0xff6199f6);
  static const Color grey = Color(0xffA4A4A4);
  static const Color light = Color(0xffD0D0D0);
  static const Color lightSheet = Color(0xffF5F5F5);
  static const Color blueLight = Color(0xffC7D0EB);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color green = Color(0xff50C474);
  static const Color red = Color(0xffF65151);
  static const Color redCustom = Color(0xffFF7664);
  static const Color card = Color(0xffE5E5E5);
  static const Color title = Color(0xffEFF0F6);
  static const Color disabled = Color(0xffC8D1E1);
  static const Color subtitle = Color(0xff7890CD);
  static const Color stroke = Color(0xffDBDBDB);

  static const Color gradientStart = Color(0xff667eea);
  static const Color gradientEnd = Color(0xff764ba2);

  static const Color blueGradientStart = Color(0xff4684e7);
  static const Color blueGradientEnd = Color(0xff6199f6);

  static const Color greenGradientStart = Color(0xff50C474);
  static const Color greenGradientEnd = Color(0xff43A047);

  static const Color redGradientStart = Color(0xffFF7664);
  static const Color redGradientEnd = Color(0xffF65151);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueGradientStart, blueGradientEnd],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [greenGradientStart, greenGradientEnd],
  );

  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [redGradientStart, redGradientEnd],
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient primaryGradientHorizontal = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );

  static const RadialGradient primaryRadialGradient = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient darkTealGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0f3460), Color(0xFF1e6091), Color(0xFF58a4b0)],
  );
  
  static const LinearGradient darkTealGradientRow = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF0f3460), Color(0xFF1e6091), Color(0xFF58a4b0)],
  );
}
