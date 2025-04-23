import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/generated/l10n.dart';

class BestSellerHeader extends StatelessWidget {
  const BestSellerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            S.of(context).mostSelling,
            textAlign: TextAlign.right,
            style: AppSTextStyles.bold16(null),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Text(
              S.of(context).viewMore,
              textAlign: TextAlign.center,
              style: AppSTextStyles.regular13(AppColors.lightSubtitleColor),
            ),
          ),
        ],
      ),
    );
  }
}
