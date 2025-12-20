import 'package:flutter/material.dart';
import 'package:fruits_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:fruits_app/features/auth/presentation/views/login_view.dart';
import 'package:fruits_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:fruits_app/features/entery/presentation/views/onboarding_view.dart';
import 'package:fruits_app/features/entery/presentation/views/splash_view.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity.dart';
import 'package:fruits_app/features/home/domain/entity/cart_entity_list.dart';

import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/presentation/views/home_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.id:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnboardingView.id:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case LoginView.id:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case RegisterView.id:
      return MaterialPageRoute(builder: (_) => const RegisterView());
    case HomeView.id:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case ForgetPasswordView.id:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case CheckoutView.id:
      return MaterialPageRoute(
        builder:
            (_) =>
                CheckoutView(cartItems: settings.arguments as CartEntityList),
      );
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
