import 'package:flutter/material.dart';

class MyConstant {
//field
  static Color dark = const Color.fromARGB(255, 36, 4, 100);
  static Color primary = const Color.fromARGB(255, 14, 93, 210);
  static Color active = const Color.fromARGB(255, 161, 16, 139);
  static Color light = const Color.fromARGB(255, 93, 139, 207);

  static double factorSize = 0.6;

//method
  BoxDecoration gradienRadienBox() {
    return BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0.35, -0.35),
        radius: 1.0,
        colors: [Colors.white, primary],
      ),
    );
  }

  BoxDecoration planBox() {
    return BoxDecoration(color: light.withOpacity(0.75));
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 36,
      color: dark,
      fontWeight: FontWeight.bold,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 20,
      color: dark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h2WhiteStyle() {
    return const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 16,
      color: dark,
      fontWeight: FontWeight.normal,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h3WhiteStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h3HintStyle() {
    return TextStyle(
      fontSize: 16,
      color: light,
      fontWeight: FontWeight.normal,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 18,
      color: active,
      fontWeight: FontWeight.w500,
      fontFamily: 'Prompt',
    );
  }

  TextStyle h3ButtonStyle() {
    return const TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: 'Prompt',
    );
  }
}
