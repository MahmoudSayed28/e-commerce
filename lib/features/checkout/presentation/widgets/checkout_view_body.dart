import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/widgets/custem_eleveted_button.dart';
import 'package:fruits_app/core/utils/widgets/custom_snak_bar.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/cubits/add_order/add_order_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/cubits/payment/payment_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_page_view.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/step_item.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late PageController pageController;

  final ValueNotifier<AutovalidateMode> autovalidateModeNotifier =
      ValueNotifier(AutovalidateMode.disabled);

  int currentIndex = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    pageController.addListener(() {
      final page = pageController.page;

      if (page != null) {
        setState(() {
          currentIndex = page.round();
        });
      }
    });
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

    final steps = [
      S.of(context).shipping,
      S.of(context).address,
      S.of(context).review,
    ];

    return MultiBlocListener(
      listeners: [
        // =========================================================
        // CASH ORDER
        // =========================================================
        BlocListener<AddOrderCubit, AddOrderState>(
          listener: (context, state) {
            if (state is AddOrderLoading) {
              setState(() {
                isLoading = true;
              });
            }

            if (state is AddOrderSuccess) {
              final orderId = state.orderId;

              // ==============================
              // CASH
              // ==============================
              if (orderProvider.payWithCash == true) {
                setState(() {
                  isLoading = false;
                });

                showCustomSnackBar(
                  context,
                  message: S.of(context).orderPlacedSuccessfully,
                  isError: false,
                );

                Navigator.pop(context);

                return;
              }

              // ==============================
              // CARD
              // ==============================
              log('STARTING PAYMOB PAYMENT');
              log('ORDER ID = $orderId');

              context.read<PaymentCubit>().createPayment(orderId: orderId);
            }

            if (state is AddOrderFailure) {
              setState(() {
                isLoading = false;
              });

              showCustomSnackBar(context, message: state.errorMessage);
            }

            // =====================================================
            // CARD ORDER DRAFT CREATED
            // =====================================================
          },
        ),

        // =========================================================
        // PAYMOB
        // =========================================================
        BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            if (state is PaymentLoading) {
              setState(() {
                isLoading = true;
              });

              return;
            }

            if (state is PaymentSuccess) {
              setState(() {
                isLoading = false;
              });

              log('PAYMOB PAYMENT CREATED');
              log('Payment URL: ${state.paymentUrl}');

              final uri = Uri.tryParse(state.paymentUrl);

              if (uri == null) {
                showCustomSnackBar(context, message: 'Invalid payment URL');
                return;
              }

              final launched = await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );

              if (!launched) {
                showCustomSnackBar(
                  context,
                  message: 'Could not open payment page',
                );
              }

              return;
            }

            if (state is PaymentFailure) {
              setState(() {
                isLoading = false;
              });

              log('PAYMOB ERROR: ${state.errorMessage}');

              showCustomSnackBar(context, message: state.errorMessage);
            }
          },
        ),
      ],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 12),
          child: Column(
            children: [
              // =====================================================
              // STEPS
              // =====================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(steps.length, (index) {
                  return GestureDetector(
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
                      stepTitle: steps[index],
                      stepNumber: (index + 1).toString(),
                      isActive: index <= currentIndex,
                    ),
                  );
                }),
              ),

              // =====================================================
              // PAGE VIEW
              // =====================================================
              Expanded(
                child: CheckoutPageView(
                  pageController: pageController,
                  formKey: formKey,
                  autovalidateModeNotifier: autovalidateModeNotifier,
                ),
              ),

              // =====================================================
              // MAIN BUTTON
              // =====================================================
              CustomElevetedButton(
                text:
                    currentIndex != 2
                        ? S.of(context).next
                        : orderProvider.payWithCash == true
                        ? S.of(context).orderNow
                        : S.of(context).payNow,
                onPressed: () {
                  log('==============================');
                  log('CHECKOUT BUTTON PRESSED');
                  log('currentIndex = $currentIndex');
                  log('payWithCash = ${orderProvider.payWithCash}');
                  log('==============================');

                  // =================================================
                  // STEP 1
                  // =================================================
                  if (currentIndex == 0) {
                    _handleShippingSection(orderProvider, context);
                    return;
                  }

                  // =================================================
                  // STEP 2
                  // =================================================
                  if (currentIndex == 1) {
                    _handleAdderssSection();
                    return;
                  }

                  // =================================================
                  // STEP 3
                  // =================================================
                  if (currentIndex == 2) {
                    // ===============================================
                    // CASH
                    // ===============================================
                    if (orderProvider.payWithCash == true) {
                      log('PAYMENT METHOD = CASH');

                      context.read<AddOrderCubit>().addCashOrder(
                        order: orderProvider,
                      );

                      return;
                    }

                    // ===============================================
                    // CARD
                    // ===============================================
                    log('PAYMENT METHOD = CARD');

                    context.read<AddOrderCubit>().createCardOrderDraft(
                      order: orderProvider,
                    );

                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // STEP 1 - SHIPPING
  // ===============================================================

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

  // ===============================================================
  // STEP 2 - ADDRESS
  // ===============================================================

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
}
