import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  Color primaryColor = const Color(0xFF00ADEF);

  List<Color> colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.brown,
    // Add more colors as needed
  ];

  static Color randomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  static Color predefinedColors() {
    final Random random = Random();
    return AppColors().colors[random.nextInt(AppColors().colors.length)];
  }
}
