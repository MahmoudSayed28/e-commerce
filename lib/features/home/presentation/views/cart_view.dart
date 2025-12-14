import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_view_body.dart';
import 'package:fruits_app/generated/l10n.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String id = 'cartview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(S.of(context).theCart),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final cartItems = cartCubit.cartItems.cartItems;

          return CartViewBody(
            itemCount: cartItems.length,
            cartItems: cartItems,
          );
        },
      ),
    );
  }
}
