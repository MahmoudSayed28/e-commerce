import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/core/utils/widgets/custom_snak_bar.dart';
import 'package:fruits_app/features/checkout/domain/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_page_view.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/step_item.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late PageController pageController;
  ValueNotifier<AutovalidateMode> autovalidateModeNotifier = ValueNotifier(
    AutovalidateMode.disabled,
  );
  int currentIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    autovalidateModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderEntity>();

    List<String> steps() {
      return [
        S.of(context).shipping,
        S.of(context).address,
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
              (index) => GestureDetector(
                onTap: () {
                  bool canNavigate = true;

                  if (index > currentIndex) {
                    if (currentIndex == 0) {
                      _handleShippingSection(orderProvider, context);
                      canNavigate = orderProvider.payWithCash != null;
                    } else if (currentIndex == 1) {
                      canNavigate = formKey.currentState!.validate();
                      if (!canNavigate) {
                        autovalidateModeNotifier.value =
                            AutovalidateMode.always;
                      }
                    }
                  }

                  if (canNavigate) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                },
                child: StepItem(
                  stepTitle: steps()[index],
                  stepNumber: (index + 1).toString(),
                  isActive: index <= currentIndex,
                ),
              ),
            ),
          ),
          Expanded(
            child: CheckoutPageView(
              pageController: pageController,
              formKey: formKey,
              autovalidateModeNotifier: autovalidateModeNotifier,
            ),
          ),
          CustomElevetedButton(
            text: S.of(context).next,
            onPressed: () {
              if (currentIndex == 0) {
                _handleShippingSection(orderProvider, context);
              } else if (currentIndex == 1) {
                _handleAdderssSection();
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleAdderssSection() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      autovalidateModeNotifier.value = AutovalidateMode.always;
    }
  }

  void _handleShippingSection(OrderEntity orderProvider, BuildContext context) {
    if (orderProvider.payWithCash != null) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      showCustomSnackBar(context, message: S.of(context).selectPaymentMethod);
    }
  }
}
