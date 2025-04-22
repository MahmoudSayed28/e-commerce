import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/generated/l10n.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).goodMorning,
            style: AppSTextStyles.regular16(AppColors.lightSubtitleColor),
          ),
          Text(
            CacheHelper.getString(kUserName)!,
            style: AppSTextStyles.bold16(null),
          ),
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.cardColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(Assets.assetsImagesNotification),
        ),
      ],
      leading: Padding(
        padding: EdgeInsets.all(6.0),
        child: Image.asset(Assets.assetsImagesProfileImage, height: 54),
      ),
    );
  }
}
