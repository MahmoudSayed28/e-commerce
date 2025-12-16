import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/active_step.dart';
import 'package:fruits_app/features/checkout/presentation/widgets/inactive_step.dart';

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.stepTitle,
    required this.stepNumber,
    required this.isActive,
  });
  final String stepTitle, stepNumber;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: InactiveStep(stepTitle: stepTitle, stepNumber: stepNumber),
      secondChild: ActiveStep(stepTitle: stepTitle),
      crossFadeState:
          isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 500),
    );
  }
}
