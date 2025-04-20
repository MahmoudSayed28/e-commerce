import 'package:flutter/material.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/utils/constant.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';
import 'package:fruits_app/features/entery/presentation/views/onboarding_view.dart';
import 'package:fruits_app/features/entery/presentation/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const id = 'SplashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    bool isOnBoardingViewSeen =
        CacheHelper.getData(key: kIsOnBoardingViewSeen) ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        isOnBoardingViewSeen
            ? Navigator.pushReplacementNamed(context, LoginView.id)
            : Navigator.pushReplacementNamed(context, OnboardingView.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: SplashViewBody()));
  }
}
