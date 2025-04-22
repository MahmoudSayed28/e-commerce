// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Welcome to`
  String get home_intro_title1 {
    return Intl.message(
      'Welcome to',
      name: 'home_intro_title1',
      desc: '',
      args: [],
    );
  }

  /// `Search and Shop`
  String get home_intro_title2 {
    return Intl.message(
      'Search and Shop',
      name: 'home_intro_title2',
      desc: '',
      args: [],
    );
  }

  /// `Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and enjoy the best deals with top quality.`
  String get home_intro_subtitle1 {
    return Intl.message(
      'Discover a unique shopping experience with FruitHUB. Explore our wide selection of premium fresh fruits and enjoy the best deals with top quality.',
      name: 'home_intro_subtitle1',
      desc: '',
      args: [],
    );
  }

  /// `We offer you the finest carefully selected fruits. Check details, images, and reviews to make sure you're choosing the perfect fruit.`
  String get fruit_intro_subtitle2 {
    return Intl.message(
      'We offer you the finest carefully selected fruits. Check details, images, and reviews to make sure you\'re choosing the perfect fruit.',
      name: 'fruit_intro_subtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get start {
    return Intl.message('Start Now', name: 'start', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forget Password?`
  String get forgotPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get haveNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'haveNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Continue with Google`
  String get googleLogin {
    return Intl.message(
      'Continue with Google',
      name: 'googleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get appleLogin {
    return Intl.message(
      'Continue with Apple',
      name: 'appleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get facebookLogin {
    return Intl.message(
      'Continue with Facebook',
      name: 'facebookLogin',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to `
  String get termsAgreement {
    return Intl.message(
      'By creating an account, you agree to ',
      name: 'termsAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Our Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Our Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry, just enter your email address and we'll send you a verification code.`
  String get emailVerification {
    return Intl.message(
      'Don\'t worry, just enter your email address and we\'ll send you a verification code.',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCode {
    return Intl.message('Verify Code', name: 'verifyCode', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `New Account`
  String get newAccount {
    return Intl.message('New Account', name: 'newAccount', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Value Required`
  String get required {
    return Intl.message('Value Required', name: 'required', desc: '', args: []);
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get accountExists {
    return Intl.message(
      'The account already exists for that email.',
      name: 'accountExists',
      desc: '',
      args: [],
    );
  }

  /// `there is an error try later`
  String get authError {
    return Intl.message(
      'there is an error try later',
      name: 'authError',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the terms and conditions to proceed.`
  String get acceptTerms {
    return Intl.message(
      'Please accept the terms and conditions to proceed.',
      name: 'acceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invaildEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invaildEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwordNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwordNumber',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get userNotFound {
    return Intl.message(
      'No user found for that email.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get wrongPassword {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Good morning!`
  String get good_morning {
    return Intl.message(
      'Good morning!',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
