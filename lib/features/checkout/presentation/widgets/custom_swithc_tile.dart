import 'package:flutter/material.dart';

class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.spacing = 5,
    this.switchScale = 0.73,
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget title;
  final double spacing;
  final double switchScale;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: padding,
      child: Row(children: isRTL ? _rtlChildren() : _ltrChildren()),
    );
  }

  List<Widget> _rtlChildren() {
    return [
      Directionality(
        textDirection: TextDirection.rtl,

        child: Transform.scale(
          scale: switchScale,
          child: Switch(value: value, onChanged: onChanged),
        ),
      ),
      SizedBox(width: spacing),
      Expanded(child: title),
    ];
  }

  List<Widget> _ltrChildren() {
    return [
      Directionality(
        textDirection: TextDirection.ltr,
        child: Transform.scale(
          scale: switchScale,
          child: Switch(value: value, onChanged: onChanged),
        ),
      ),
      SizedBox(width: spacing),

      title,
    ];
  }
}
