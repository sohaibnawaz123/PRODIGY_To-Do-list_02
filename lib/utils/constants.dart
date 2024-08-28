import 'package:flutter/material.dart';

class AppConstants {
  static Color appbg = const Color(0xFFeff6ff);
  static Color appBARbg = const Color(0xFF3b82f6);
  static Color headingColor = const Color(0xFF1e3a8a);
  static Color textColor = const Color(0xFF191919);
  static Color textColor2 = const Color(0xFFf9fafb);
  static Color cardBG = const Color(0xFFFFFFFF);
  static Color appErrorColor = const Color.fromARGB(255, 206, 75, 66);
  static Color appSuccessColor = const Color.fromARGB(255, 37, 155, 42);
}

TextStyle headingText(Color color,double size,{Color shadowColor = Colors.white}) {
  return TextStyle(
    fontFamily: 'Akaya',
    fontSize: size,
    color: color,
    shadows: [
     Shadow(color:shadowColor,offset: const Offset(1.5, 1),blurRadius: 5) 
    ],
  );
}
TextStyle appText(Color color,double size) {
  return TextStyle(
    fontFamily: 'Kodchasan',
    fontSize: size,
    color: color,
  );
}
