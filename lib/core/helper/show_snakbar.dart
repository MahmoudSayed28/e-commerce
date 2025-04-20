import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';

showCustomSnakBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: AppSTextStyles.regular13(Colors.white)),
    ),
  );
}
