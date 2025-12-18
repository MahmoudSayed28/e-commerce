import 'package:flutter/material.dart';

import 'package:fruits_app/features/checkout/presentation/widgets/shipping_payment_method.dart';
import 'package:fruits_app/generated/l10n.dart';

class ShippingSection extends StatefulWidget {
  const ShippingSection({super.key});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          ShippingPaymentMethod(
            title: S.of(context).cashOnDelivery,
            subTitle: S.of(context).deliveryFromPlace,
            price: "40",
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          const SizedBox(height: 12),
          ShippingPaymentMethod(
            title: S.of(context).payOnline,
            subTitle: S.of(context).selectPaymentMethod,
            price: "40",
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
