import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:fruits_app/core/helper/local_helper.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/features/home/presentation/widgets/featured_item_button.dart';
import 'package:fruits_app/generated/l10n.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width - 32;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 2.16,
        child: Stack(
          children: [
            Positioned(
              left: getLocal() == 'ar' ? 0 : width * .4,
              top: 0,
              bottom: 0,
              right: getLocal() == 'ar' ? width * .4 : 0,
              child: SvgPicture.asset(
                Assets.assetsImagesPageViewItem2Image,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: width / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: svg.Svg(Assets.assetsImagesFeaturedItemBackground),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment:
                      getLocal() == 'ar'
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,

                  children: [
                    const SizedBox(height: 25),
                    Text(
                      S.of(context).offer,
                      style: AppSTextStyles.regular13(Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      S.of(context).discount,
                      style: AppSTextStyles.bold19(Colors.white),
                    ),
                    const SizedBox(height: 11),
                    FeaturedItemButton(onPressed: () {}),
                    const SizedBox(height: 29),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
