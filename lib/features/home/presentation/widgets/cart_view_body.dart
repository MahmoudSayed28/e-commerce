import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_item_list_view.dart';
import 'package:fruits_app/generated/l10n.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

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
                  "${S.of(context).have} 3 ${S.of(context).itemsInCart} ${S.of(context).cart}",
                  style: AppTextStyles.medium15(AppColors.primaryColor),
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CartItemsListView(cartEntity: []),
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
            text: S.of(context).pay,
          ),
        ),
      ],
    );
  }
}
