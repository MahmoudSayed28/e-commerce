import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';

class CartItemActionButtons extends StatelessWidget {
  const CartItemActionButtons({super.key, required this.cartEntity});
  final CartEntity cartEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemCubit, CartItemState>(
      builder: (context, state) {
        return Row(
          children: [
            CartItemActionButton(
              iconColor: Colors.white,
              icon: Icons.add,
              color: AppColors.primaryColor,
              onPressed: () {
                cartEntity.increasCount();
                context.read<CartItemCubit>().cartItemUpdated(cartEntity);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                cartEntity.quantity.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyles.bold16(null),
              ),
            ),
            CartItemActionButton(
              iconColor: Colors.grey,
              icon: Icons.remove,
              color: const Color(0xFFF3F5F7),
              onPressed: () {
                cartEntity.decreasCount();
                context.read<CartItemCubit>().cartItemUpdated(cartEntity);
              },
            ),
          ],
        );
      },
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
