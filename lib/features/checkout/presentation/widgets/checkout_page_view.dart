import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/addres_section.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/review_section.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/shipping_section.dart';

class CheckoutPageView extends StatelessWidget {
  const CheckoutPageView({
    super.key,
    required this.pageController,
    required this.formKey, required this.autovalidateModeNotifier,
  });
  final GlobalKey<FormState> formKey;
  final PageController pageController;
final ValueNotifier<AutovalidateMode> autovalidateModeNotifier;
  @override
  Widget build(BuildContext context) {
    List<Widget> sections = [
      const ShippingSection(),
      AddresSection(formKey: formKey,autovalidateModeNotifier:autovalidateModeNotifier ,),
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
