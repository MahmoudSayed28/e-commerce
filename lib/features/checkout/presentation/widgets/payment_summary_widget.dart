import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_decorations.dart';
import 'package:fruits_app/core/utils/app_styles.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: AppTextStyles.bold13(null)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: AppDecorations.greyBoxDecoration,
          child: child,
        ),
      ],
    );
  }
}
