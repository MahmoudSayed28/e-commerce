import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/local_helper.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/features/entery/presentation/widgets/page_view_item.dart';
import 'package:fruits_app/generated/l10n.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisable: true,
          image: Assets.assetsImagesPageViewItem1Image,
          backgroundImage: Assets.assetsImagesPageViewItem1BackgroundImage,
          subtitle: S.of(context).home_intro_subtitle1,
          title:
              getLocal() == 'ar'
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).home_intro_title1,
                        style: AppTextStyles.bold23(null),
                      ),
                      Text(
                        'HUB',
                        style: AppTextStyles.bold23(AppColors.secondaryColor),
                      ),
                      Text('Fruits', style: AppTextStyles.bold23(null)),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).home_intro_title1,
                        style: AppTextStyles.bold23(null),
                      ),
                      Text('Fruits', style: AppTextStyles.bold23(null)),
                      Text(
                        'HUB',
                        style: AppTextStyles.bold23(AppColors.secondaryColor),
                      ),
                    ],
                  ),
        ),
        PageViewItem(
          isVisable: false,

          image: Assets.assetsImagesPageViewItem2Image,
          backgroundImage: Assets.assetsImagesPageViewItem2BackgroundImage,
          subtitle: S.of(context).fruit_intro_subtitle2,
          title: Text(
            S.of(context).home_intro_title2,
            style: AppTextStyles.bold23(null),
          ),
        ),
      ],
    );
  }
}
