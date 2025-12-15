import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_actions_button.dart';
import 'package:fruits_app/generated/l10n.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartEntity});
  final CartEntity cartEntity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemCubit, CartItemState>(
      buildWhen: (previous, current) {
        if (current is CartItemUpdated) {
          if (current.cartEntity == cartEntity) {
            return true;
          }
        }
        return false;
      },
      builder: (context, state) {
        return IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 73,
                height: 92,
                decoration: const BoxDecoration(color: Color(0xFFF3F5F7)),
                child: CachedNetworkImage(
                  imageUrl: cartEntity.product.imageUrl ?? '',
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          cartEntity.product.name,
                          style: AppTextStyles.bold13(null),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().removeCart(cartEntity);
                          },
                          child: SvgPicture.asset(Assets.assetsImagesTrash),
                        ),
                      ],
                    ),
                    Text(
                      '${cartEntity.totalWeight} ${S.of(context).unit}',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.regular13(AppColors.secondaryColor),
                    ),
                    Row(
                      children: [
                        CartItemActionButtons(cartEntity: cartEntity),
                        const Spacer(),
                        Text(
                          '${cartEntity.totalPrice} ${S.of(context).pound}',
                          style: AppTextStyles.bold16(AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
