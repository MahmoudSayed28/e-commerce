import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/generated/l10n.dart';

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({super.key, required this.resultsCount});
  final int resultsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          " $resultsCount ${S.of(context).results} ",
          style: AppSTextStyles.bold13(null),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.assetsImagesFilter2),
        ),
      ],
    );
  }
}
