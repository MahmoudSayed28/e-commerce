import 'package:flutter/widgets.dart';
import 'package:fruits_app/generated/l10n.dart';

String? validateEmail(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    return S.of(context).required;
  }

  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  if (!emailRegex.hasMatch(value.trim())) {
    return S.of(context).invaildEmail;
  }

  return null;
}
