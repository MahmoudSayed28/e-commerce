import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';

PreferredSizeWidget customHomeAppBar(String title) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(Assets.assetsImagesNotification),
      ),
    ],
    title: Text(title),
    centerTitle: true,
    surfaceTintColor: Colors.white,
  );
}
