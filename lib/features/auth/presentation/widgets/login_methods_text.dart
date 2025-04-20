import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text1,
    required this.text2,
    this.onPressed,
  });
  final String text1, text2;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: AppSTextStyles.semiBold16(AppColors.lightSubtitleColor),
          ),
          TextSpan(
            recognizer:
                onPressed != null
                    ? (TapGestureRecognizer()..onTap = onPressed)
                    : null,

            text: text2,
            style: AppSTextStyles.semiBold16(AppColors.lightPrimaryColor),
          ),
        ],
      ),
    );
  }
}
