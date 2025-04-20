import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';
import 'package:fruits_app/generated/l10n.dart';

import 'package:svg_flutter/svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subtitle,
    required this.title,
    required this.isVisable,
  });
  final String image, backgroundImage, subtitle;
  final bool isVisable;
  final Widget title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                left: 0,
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(image),
              ),
              Visibility(
                visible: isVisable,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () {
                      CacheHelper.setBool(kIsOnBoardingViewSeen, true);
                      Navigator.pushReplacementNamed(context, LoginView.id);
                    },
                    child: Text(
                      S.of(context).skip,
                      style: AppSTextStyles.regular16(AppColors.subtitleColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 64),
        title,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            subtitle,
            style: AppSTextStyles.regular13(AppColors.subtitleColor),
          ),
        ),
      ],
    );
  }
}
