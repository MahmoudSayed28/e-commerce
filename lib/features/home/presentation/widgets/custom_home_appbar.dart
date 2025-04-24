import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/generated/l10n.dart';

class CustomHomeAppbar extends StatefulWidget {
  const CustomHomeAppbar({super.key, required this.isScrolled});
  final bool isScrolled;

  @override
  State<CustomHomeAppbar> createState() => _CustomHomeAppbarState();
}

class _CustomHomeAppbarState extends State<CustomHomeAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.white,
      pinned: true,
      elevation: 0,
      expandedHeight: 0,
      backgroundColor: Colors.white,

      title: AnimatedCrossFade(
        firstChild: Center(
          child: Text(
            S.of(context).mostSelling,
            style: AppSTextStyles.bold19(null),
          ),
        ),
        secondChild: Column(
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
        crossFadeState:
            widget.isScrolled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 400),
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
        padding: const EdgeInsets.all(6.0),
        child: Image.asset(Assets.assetsImagesProfileImage, height: 54),
      ),
    );
  }
}
