import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/generated/l10n.dart';

class CustemTextFormField extends StatelessWidget {
  const CustemTextFormField({
    super.key,
    required this.hintText,
    this.onChanged,
  });
  final String hintText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? S.of(context).required : null,
      style: AppSTextStyles.semiBold16(null),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppSTextStyles.semiBold16(null),
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        border: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: Color(0xffE6E9EA), width: 1),
  );
}
