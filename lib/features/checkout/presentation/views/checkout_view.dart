import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/features/checkout/domain/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_view_body.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.cartItems});
  static const String id = 'CheckoutView';
  final CartEntityList cartItems;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? userId;
  @override
  void initState() {
    super.initState();
    _getUserId();
    log('userId: $userId');
  }

  Future<void> _getUserId() async {
    final id = await getUserID();
    if (!mounted) return;
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shipping, style: AppTextStyles.bold19(null)),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create:
            (context) =>
                OrderEntity(cartItemList: widget.cartItems, uId: userId ?? ""),
        child: const CheckoutViewBody(),
      ),
    );
  }
}
