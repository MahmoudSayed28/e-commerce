import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_page_view.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/step_item.dart';
import 'package:fruits_app/generated/l10n.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> steps() {
      return [
        S.of(context).shipping,
        S.of(context).address,
        S.of(context).payment,
        S.of(context).review,
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              steps().length,
              (index) => StepItem(
                stepTitle: steps()[index],
                stepNumber: (index + 1).toString(),
                isActive: true,
              ),
            ),
          ),
          Expanded(child: CheckoutPageView(pageController: pageController)),
          CustomElevetedButton(text: S.of(context).next, onPressed: () {}),
        ],
      ),
    );
  }
}
