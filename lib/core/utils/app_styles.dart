import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle bold(double size, Color? color) {
    return TextStyle(fontWeight: FontWeight.w700, fontSize: size, color: color);
  }

  static TextStyle semiBold(double size, Color? color) {
    return TextStyle(fontWeight: FontWeight.w600, fontSize: size, color: color);
  }

  static TextStyle medium(double size, Color? color) {
    return TextStyle(fontWeight: FontWeight.w500, fontSize: size, color: color);
  }

  static TextStyle regular(double size, Color? color) {
    return TextStyle(fontWeight: FontWeight.w400, fontSize: size, color: color);
  }

  // Methods that accept color as non-nullable and directly set the size
  static TextStyle bold13(Color? color) => bold(13, color);
  static TextStyle bold23(Color? color) => bold(23, color);
  static TextStyle semiBold13(Color? color) => semiBold(13, color);
  static TextStyle regular13(Color? color) => regular(13, color);
  static TextStyle bold16(Color? color) => bold(16, color);
  static TextStyle bold19(Color? color) => bold(19, color);
  static TextStyle semiBold16(Color? color) => semiBold(16, color);
  static TextStyle bold28(Color? color) => bold(28, color);
  static TextStyle regular22(Color? color) => regular(22, color);
  static TextStyle semiBold11(Color? color) => semiBold(11, color);
  static TextStyle medium15(Color? color) => medium(15, color);
  static TextStyle regular26(Color? color) => regular(26, color);
  static TextStyle regular16(Color? color) => regular(16, color);
  static TextStyle regular11(Color? color) => regular(11, color);
}
