import 'package:flutter/widgets.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/generated/l10n.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String name;

  BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });
}

List<BottomNavigationBarEntity> bottomNavigationBarItems(BuildContext context) {
  return [
    BottomNavigationBarEntity(
      activeImage: Assets.assetsImagesVuesaxBoldHome,
      inActiveImage: Assets.assetsImagesVuesaxOutlineHome,
      name: S.of(context).home,
    ),
    BottomNavigationBarEntity(
      activeImage: Assets.assetsImagesVuesaxBoldProducts,
      inActiveImage: Assets.assetsImagesVuesaxOutlineProducts,
      name: S.of(context).products,
    ),
    BottomNavigationBarEntity(
      activeImage: Assets.assetsImagesVuesaxBoldShoppingCart,
      inActiveImage: Assets.assetsImagesVuesaxOutlineShoppingCart,
      name: S.of(context).cart,
    ),
    BottomNavigationBarEntity(
      activeImage: Assets.assetsImagesVuesaxBoldUser,
      inActiveImage: Assets.assetsImagesVuesaxOutlineUser,
      name: S.of(context).account,
    ),
  ];
}
