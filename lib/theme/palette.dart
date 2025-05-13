import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor background = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF), // Background Primary
      200: Color(0xFFF4F6F8), // Background Secondary
      300: Color(0xFFE4E8EB), // Background Tertiary

      700: Color(0xFF121212), // Background Dark Tertiary
      800: Color(0xFF1E1E1E), // Background Dark Secondary
      900: Color(0xFF000000), // Background Dark Primary
    },
  );

  static const MaterialColor label = MaterialColor(0xFF000B17, <int, Color>{
    50: Color(0xFF000000), // Label Primary
    100: Color(0xFFA9B0BB), // Label Secondary
    200: Color(0xFFB3B8BE), // Label Tertiary

    500: Color(0xFFFFFFFF), // Label Dark Primary
    600: Color(0xFFB0BEC5), // Label Dark Secondary
    700: Color(0xFF757575), // Label Tertiary
  });

  static const MaterialColor icon = MaterialColor(0xFF9298A3, <int, Color>{
    50: Color(0xFF9298A3), // Label Primary
    100: Color(0xFFCAD0D7), // Label Secondary

    500: Color(0xFFFFFFFF), // Label Dark Primary
    600: Color(0xFFB0BEC5), // Label Dark Secondary
  });

  static const MaterialColor primary = MaterialColor(0xFFFF9521, <int, Color>{
    50: Color(0xFFFF9521), // Light
    900: Color(0xFFFF9521), // Dark
  });
  static const MaterialColor success = MaterialColor(0xFF89C053, <int, Color>{
    50: Color(0xFF89C053), // Light,
    900: Color(0xFF89C053), // Dark,
  });
  static const MaterialColor warning = MaterialColor(0xFFFFC908, <int, Color>{
    50: Color(0xFFFFC908), // Light,
    900: Color(0xFFFDD835), // Dark,
  });
  static const MaterialColor danger = MaterialColor(0xFFE8553E, <int, Color>{
    50: Color(0xFFE8553E), // Light,
    900: Color(0xFFE8553E), // Dark,
  });
}
