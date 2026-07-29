import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/widgets/custom_text_feild.dart';
import 'package:fruits_app/features/checkout/domain/entity/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/custom_swithc_tile.dart';
import 'package:fruits_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class AddresSection extends StatefulWidget {
  const AddresSection({
    super.key,
    required this.formKey,
    required this.autovalidateModeNotifier,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> autovalidateModeNotifier;
  @override
  State<AddresSection> createState() => _AddresSectionState();
}

class _AddresSectionState extends State<AddresSection> {
  bool saveAddress = false;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderEntity>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: widget.autovalidateModeNotifier,
          builder: (context, value, child) {
            return Form(
              autovalidateMode: value,
              key: widget.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.name = value;
                    },
                    hintText: S.of(context).fullName,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 12),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.email = value;
                    },
                    hintText: S.of(context).email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.address = value;
                    },
                    hintText: S.of(context).address,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 12),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.city = value;
                    },
                    hintText: S.of(context).city,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 12),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.addressDetails = value;
                    },
                    hintText:
                        "${S.of(context).floorNumber}, ${S.of(context).apartmentNumber}",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  CustemTextFormField(
                    onChanged: (value) {
                      provider.shippingEntity.phone = value;
                    },
                    hintText: S.of(context).phoneNumber,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  AppSwitchTile(
                    value: saveAddress,
                    onChanged: (v) {
                      setState(() {
                        saveAddress = v;
                      });
                    },
                    title: Text(
                      S.of(context).saveAddress,
                      style: AppTextStyles.semiBold13(const Color(0xff949D9E)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
