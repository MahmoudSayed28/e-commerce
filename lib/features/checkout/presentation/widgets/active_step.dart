import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';

class ActiveStep extends StatelessWidget {
  const ActiveStep({super.key, required this.stepTitle});
  final String stepTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 11.5,
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 4),
        Text(stepTitle, style: AppTextStyles.bold13(AppColors.primaryColor)),
      ],
    );
  }
}
