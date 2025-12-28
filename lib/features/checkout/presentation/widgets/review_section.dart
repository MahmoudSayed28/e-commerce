import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/order_summary.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/shipping_address_widget.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          const OrderSummryWidget(),
          const SizedBox(height: 16),
          ShippingAddressWidget(pageController: pageController,),
        ],
      ),
    );
  }
}
