import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';

class CartItemActionButtons extends StatelessWidget {
  const CartItemActionButtons({
    super.key,
    required this.incrementQuantity,
    required this.decrementQuantity,
    required this.quantity,
  });
  final void Function() incrementQuantity, decrementQuantity;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CartItemActionButton(
          iconColor: Colors.white,
          icon: Icons.add,
          color: AppColors.primaryColor,
          onPressed: incrementQuantity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            quantity.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyles.bold16(null),
          ),
        ),
        CartItemActionButton(
          iconColor: Colors.grey,
          icon: Icons.remove,
          color: const Color(0xFFF3F5F7),
          onPressed: decrementQuantity,
        ),
      ],
    );
  }
}

class CartItemActionButton extends StatelessWidget {
  const CartItemActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.iconColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: FittedBox(child: Icon(icon, color: iconColor)),
      ),
    );
  }
}
