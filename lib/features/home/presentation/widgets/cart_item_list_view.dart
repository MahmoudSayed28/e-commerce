import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_item.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder:
          (context, index) => Divider(color: Colors.grey.shade200, height: 1),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: CartItem(),
        );
      },
    );
  }
}
