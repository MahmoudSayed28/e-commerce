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
  ValueNotifier<AutovalidateMode> autovalidateModeNotifier = ValueNotifier(
    AutovalidateMode.disabled,
  );
  int currentIndex = 0;
  bool isLoading = false;
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

    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          isLoading = false;
          showCustomSnackBar(
            context,
            message: S.of(context).orderPlacedSuccessfully,
            isError: false,
          );
          Navigator.pop(context);
        } else if (state is AddOrderFailure) {
          isLoading = false;
          showCustomSnackBar(context, message: state.errorMessage);
        } else if (state is AddOrderLoading) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.5, vertical: 12),
            child: BlocListener<PaymentCubit, PaymentState>(
              listener: (context, state) async {
                if (state is PaymentSuccess) {
                  final url =
                      'https://accept.paymob.com/api/acceptance/iframes/915524?payment_token=${state.paymentKey}';

                  final launched = await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                  if (launched && context.mounted) {
                    context.read<AddOrderCubit>().addOrder(
                      order: orderProvider,
                    );
                  }
                }

                if (state is PaymentFailure) {
                  debugPrint(state.errorMessage);
                }
              },
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
                    text:
                        currentIndex != 2
                            ? S.of(context).next
                            : orderProvider.payWithCash == true
                            ? S.of(context).orderNow
                            : S.of(context).payNow,
                    onPressed: () {
                      if (currentIndex == 0) {
                        _handleShippingSection(orderProvider, context);
                      } else if (currentIndex == 1) {
                        _handleAdderssSection();
                      }
                      if (currentIndex == 2) {
                        if (orderProvider.payWithCash == true) {
                          context.read<AddOrderCubit>().addOrder(
                            order: orderProvider,
                          );
                        } else {
                          context.read<PaymentCubit>().createPayment(
                            order: orderProvider,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

//? https://chatgpt.com/share/6a69ef48-293c-83ea-b640-fe2670c5ba75
