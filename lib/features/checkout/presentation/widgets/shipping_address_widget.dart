import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/assets_manager.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/payment_summary_widget.dart';
import 'package:fruits_app/generated/l10n.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentSummaryWidget(
      title: S.of(context).shippingAddress,
      child: Row(
        children: [
          SvgPicture.asset(Assets.assetsImagesLocation),
          const SizedBox(width: 8),
          Text(
            "المنبا-شارع طه حسين-مبني 123",
            textAlign: TextAlign.right,
            style: AppTextStyles.regular13(const Color(0xFF4E5556)),
          ),
          const Spacer(),
          SizedBox(
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
        ],
      ),
    );
  }
}
