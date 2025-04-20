import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';

PreferredSizeWidget customAppBar(String title) {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back_ios),
    ),
    centerTitle: true,
    title: Text(title, style: AppSTextStyles.bold19(null)),
  );
}
