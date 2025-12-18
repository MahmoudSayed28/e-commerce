import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/order_summary.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/shipping_address_widget.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),
          OrderSummryWidget(),
          SizedBox(height: 16),
          ShippingAddressWidget(),
        ],
      ),
    );
  }
}
