import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/payment_summary_widget.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderEntity>();

    return PaymentSummaryWidget(
      title: S.of(context).shippingAddress,
      child: Row(
        children: [
          SvgPicture.asset(Assets.assetsImagesLocation),
          const SizedBox(width: 8),
          Text(
            provider.shippingEntity.address.toString(),
            textAlign: TextAlign.right,
            style: AppTextStyles.regular13(const Color(0xFF4E5556)),
          ),
          const Spacer(),
          SizedBox(
            child: GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(Assets.assetsImagesEdit),
                  const SizedBox(width: 4),
                  Text(
                    S.of(context).edit,
                    style: AppTextStyles.semiBold13(const Color(0xFF949D9E)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
