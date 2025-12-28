import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/domain/order_entity.dart';

import 'package:fruits_app/features/checkout/presentation/widgets/shipping_payment_method.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class ShippingSection extends StatefulWidget {
  const ShippingSection({super.key});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection> with AutomaticKeepAliveClientMixin {
  
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          ShippingPaymentMethod(
            title: S.of(context).cashOnDelivery,
            subTitle: S.of(context).deliveryFromPlace,
            price:
                (context
                            .read<OrderEntity>()
                            .cartItemList
                            .calculateTotalPrice() +
                        40)
                    .toString(),
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
                context.read<OrderEntity>().payWithCash = true;
              });
            },
          ),
          const SizedBox(height: 12),
          ShippingPaymentMethod(
            title: S.of(context).payOnline,
            subTitle: S.of(context).selectPaymentMethod,
            price:
                context
                    .read<OrderEntity>()
                    .cartItemList
                    .calculateTotalPrice()
                    .toString(),
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
                context.read<OrderEntity>().payWithCash = false;
              });
            },
          ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
