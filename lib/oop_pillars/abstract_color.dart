import 'package:flutter/material.dart';

abstract class AppColors {
  Color getColor();
}

class PrimaryColor extends AppColors {
  @override
  Color getColor() {
    return Colors.black;
  }
}

class BgColor extends AppColors {
  @override
  Color getColor() {
    return const Color.fromARGB(255, 247, 244, 244);
  }
}

class AccentColor extends AppColors {
  @override
  Color getColor() {
    return const Color.fromRGBO(251, 220, 92, 1);
  }
}
