import 'package:flutter/material.dart';

class StatusBackgroundColors {
  static Color getColor(String? status) {
    switch (status) {
      case 'New':
        return const Color(0xff5cafc5);
      case 'Progress':
        return const Color(0xffb2a963);
      case 'Cancelled':
        return const Color(0xffd06161);
      case 'Complete':
        return const Color(0xff68c07c);
      default:
        return Colors.grey; // Default color if status doesn't match any case
    }
  }
}
