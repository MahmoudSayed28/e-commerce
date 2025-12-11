import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_styles.dart';
import 'package:fruits_app/generated/l10n.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(S.of(context).or, style: AppTextStyles.semiBold16(null)),
        ),
        const CustomDivider(),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Divider(color: Color(0xFFDCDEDE)));
  }
}
