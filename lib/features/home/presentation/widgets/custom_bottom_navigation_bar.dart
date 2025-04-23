import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/features/home/domain/entity/bottom_navigation_item_entity.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color(0x19000000), blurRadius: 25, spreadRadius: 3),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            bottomNavigationBarItems(context).asMap().entries.map((entry) {
              int index = entry.key;
              BottomNavigationBarEntity iconEntity = entry.value;
              return GestureDetector(
                onTap: () => setState(() => currentIndex = index),
                child: BottomNavigationBarIcon(
                  iconEntity: iconEntity,
                  isActive: currentIndex == index,
                ),
              );
            }).toList(),
      ),
    );
  }
}

class BottomNavigationBarIcon extends StatelessWidget {
  const BottomNavigationBarIcon({
    super.key,
    required this.iconEntity,
    required this.isActive,
  });
  final BottomNavigationBarEntity iconEntity;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveIcon(image: iconEntity.activeImage, label: iconEntity.name)
        : Center(child: SvgPicture.asset(iconEntity.inActiveImage, width: 18));
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({super.key, required this.label, required this.image});
  final String label, image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: SvgPicture.asset(image)),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppSTextStyles.semiBold11(AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
