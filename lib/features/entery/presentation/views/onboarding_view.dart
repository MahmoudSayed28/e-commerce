import 'package:flutter/material.dart';
import 'package:fruits_app/features/entery/presentation/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static const String id = 'onboarding-view';
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: OnboardingViewBody()));
  }
}
