import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/addres_section.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/payment_section.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/review_section.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutPageView extends StatelessWidget {
  const CheckoutPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = [
      const ShippingSection(),
      const AddresSection(),
      const PaymentSection(),
      const ReviewSection(),
    ];
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return sections[index];
      },
      itemCount: sections.length,
      controller: pageController,
    );
  }
}
