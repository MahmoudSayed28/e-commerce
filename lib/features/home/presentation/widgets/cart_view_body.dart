import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_item_list_view.dart';
import 'package:fruits_app/generated/l10n.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({
    super.key,
    required this.cartItems,
    required this.itemCount,
  });
  final List<CartEntity> cartItems;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 41,
              color: const Color(0xffEBF9F1),
              child: Center(
                child: Text(
                  "${S.of(context).have} $itemCount ${S.of(context).itemsInCart} ${S.of(context).cart}",
                  style: AppTextStyles.medium15(AppColors.primaryColor),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CartItemsListView(cartEntity: cartItems),
              ),
            ),
          ],
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 20,

          child: CustomElevetedButton(
            onPressed: () {},
            text:
                "${S.of(context).pay} ${context.watch<CartCubit>().calculateTotalPrice()} ${S.of(context).pound}",
          ),
        ),
      ],
    );
  }
}
