import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/features/checkout/domain/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/payment_summary_widget.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class OrderSummryWidget extends StatelessWidget {
  const OrderSummryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderEntity>();
    return PaymentSummaryWidget(
      title: S.of(context).orderSummary,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                S.of(context).subtotal,
                style: AppTextStyles.regular13(const Color(0xFF4E5556)),
              ),
              const Spacer(),
              Text(
                '${provider.cartItemList.calculateTotalPrice()} ${S.of(context).pound}',
                textAlign: TextAlign.right,
                style: AppTextStyles.semiBold16(null),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                S.of(context).shipping,
                style: AppTextStyles.regular13(const Color(0xFF4E5556)),
              ),
              const Spacer(),
              Text(
                '30 ${S.of(context).pound}',
                textAlign: TextAlign.right,
                style: AppTextStyles.regular13(const Color(0xFF4E5556)),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Divider(thickness: .5, color: Color(0xFFCACECE)),
          const SizedBox(height: 9),
          Row(
            children: [
              Text(S.of(context).total, style: AppTextStyles.bold16(null)),
              const Spacer(),
              Text(
                '${provider.cartItemList.calculateTotalPrice() + 30} ${S.of(context).pound}',
                style: AppTextStyles.bold16(null),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
