import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/checkout_view_body.dart';
import 'package:fruits_app/generated/l10n.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});
  static const String id = 'CheckoutView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shipping, style: AppTextStyles.bold19(null)),
        centerTitle: true,
      ),
      body: const CheckoutViewBody(),
    );
  }
}
