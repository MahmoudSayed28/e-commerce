import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/generated/l10n.dart';

class PasswordTextFormFiels extends StatefulWidget {
  const PasswordTextFormFiels({
    super.key,
    required this.hintText,
    this.onChanged,
  });
  final String hintText;
  final void Function(String)? onChanged;

  @override
  State<PasswordTextFormFiels> createState() => _PasswordTextFormFielsState();
}

class _PasswordTextFormFielsState extends State<PasswordTextFormFiels> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:
          MultiValidator([
            RequiredValidator(errorText: S.of(context).required),
            MinLengthValidator(8, errorText: S.of(context).passwordMinLength),
            PatternValidator(
              r'^(?=.*[A-Z])',
              errorText: S.of(context).passwordUppercase,
            ),
            PatternValidator(
              r'^(?=.*\d)',
              errorText: S.of(context).passwordNumber,
            ),
          ]).call,
      onChanged: widget.onChanged,
      obscureText: isObsecure,
      style: AppTextStyles.semiBold16(null),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObsecure = !isObsecure;
            });
          },
          icon:
              isObsecure
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
        ),
        hintText: widget.hintText,
        hintStyle: AppTextStyles.semiBold16(null),
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
