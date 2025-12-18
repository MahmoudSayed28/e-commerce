import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';

class InactiveStep extends StatelessWidget {
  const InactiveStep({
    super.key,
    required this.stepTitle,
    required this.stepNumber,
  });
  final String stepTitle, stepNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 11.5,
          backgroundColor: AppColors.cardColor,
          child: Text(stepNumber, style: AppTextStyles.semiBold13(null)),
        ),
        const SizedBox(width: 6),
        FittedBox(
          child: Text(
            stepTitle,
            style: AppTextStyles.semiBold13(const Color(0xffAAAAAA)),
          ),
        ),
      ],
    );
  }
}
