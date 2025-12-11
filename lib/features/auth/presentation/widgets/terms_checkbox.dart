import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';
import 'package:fruits_app/generated/l10n.dart';

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;
  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.5),
              ),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
                widget.onChanged(_isChecked);
              },
              activeColor: Colors.green, // Green checkmark as in the image
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).termsAgreement,
                    style: AppTextStyles.semiBold13(
                      AppColors.lightSubtitleColor,
                    ),
                  ),
                  TextSpan(
                    text: S.of(context).termsAndConditions,
                    style: AppTextStyles.semiBold13(
                      AppColors.lightPrimaryColor,
                    ),
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
