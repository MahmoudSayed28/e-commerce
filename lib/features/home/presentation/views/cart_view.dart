import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/widgets/custom_home_appbar.dart';
import 'package:fruits_app/features/home/presentation/widgets/cart_view_body.dart';
import 'package:fruits_app/generated/l10n.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String id = 'cartview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customHomeAppBar(S.of(context).theCart),
      body: const CartViewBody(),
    );
  }
}
