import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_item.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({super.key, required this.cartEntity});
  final List<CartEntity> cartEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder:
          (context, index) => Divider(color: Colors.grey.shade200, height: 1),
      itemCount: cartEntity.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CartItem(cartEntity: cartEntity[index]),
        );
      },
    );
  }
}
