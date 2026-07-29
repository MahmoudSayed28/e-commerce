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
    final name = (locale.countryCode?.isEmpty ?? false)
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
  String get goodMorning {
    return Intl.message(
      'Good morning!',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `Most Selling`
  String get mostSelling {
    return Intl.message(
      'Most Selling',
      name: 'mostSelling',
      desc: '',
      args: [],
    );
  }

  /// `View More`
  String get viewMore {
    return Intl.message('View More', name: 'viewMore', desc: '', args: []);
  }

  /// `Fruit`
  String get fruit {
    return Intl.message('Fruit', name: 'fruit', desc: '', args: []);
  }

  /// `Watermelon`
  String get watermelon {
    return Intl.message('Watermelon', name: 'watermelon', desc: '', args: []);
  }

  /// `Strawberry`
  String get strawberry {
    return Intl.message('Strawberry', name: 'strawberry', desc: '', args: []);
  }

  /// ` EGP / kilo`
  String get pricePerKilo {
    return Intl.message(
      ' EGP / kilo',
      name: 'pricePerKilo',
      desc: '',
      args: [],
    );
  }

  /// `25% OFF`
  String get discount {
    return Intl.message('25% OFF', name: 'discount', desc: '', args: []);
  }

  /// `Shop Now`
  String get shopNow {
    return Intl.message('Shop Now', name: 'shopNow', desc: '', args: []);
  }

  /// `Offer`
  String get offer {
    return Intl.message('Offer', name: 'offer', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Shopping Cart`
  String get cart {
    return Intl.message('Shopping Cart', name: 'cart', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Results`
  String get results {
    return Intl.message('Results', name: 'results', desc: '', args: []);
  }

  /// `Price: High to Low`
  String get highPrice {
    return Intl.message(
      'Price: High to Low',
      name: 'highPrice',
      desc: '',
      args: [],
    );
  }

  /// `Price: Low to High`
  String get lowPrice {
    return Intl.message(
      'Price: Low to High',
      name: 'lowPrice',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get theCart {
    return Intl.message('Cart', name: 'theCart', desc: '', args: []);
  }

  /// `You have`
  String get have {
    return Intl.message('You have', name: 'have', desc: '', args: []);
  }

  /// `items in`
  String get itemsInCart {
    return Intl.message('items in', name: 'itemsInCart', desc: '', args: []);
  }

  /// `pounds`
  String get pound {
    return Intl.message('pounds', name: 'pound', desc: '', args: []);
  }

  /// `kg`
  String get unit {
    return Intl.message('kg', name: 'unit', desc: '', args: []);
  }

  /// `Pay`
  String get pay {
    return Intl.message('Pay', name: 'pay', desc: '', args: []);
  }

  /// `Added to cart:`
  String get addedToCart {
    return Intl.message(
      'Added to cart:',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Removed from cart:`
  String get removedFromCart {
    return Intl.message(
      'Removed from cart:',
      name: 'removedFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Review`
  String get review {
    return Intl.message('Review', name: 'review', desc: '', args: []);
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Cash on Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivery from location`
  String get deliveryFromPlace {
    return Intl.message(
      'Delivery from location',
      name: 'deliveryFromPlace',
      desc: '',
      args: [],
    );
  }

  /// `Pay Online`
  String get payOnline {
    return Intl.message('Pay Online', name: 'payOnline', desc: '', args: []);
  }

  /// `Please select payment method`
  String get selectPaymentMethod {
    return Intl.message(
      'Please select payment method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Floor number`
  String get floorNumber {
    return Intl.message(
      'Floor number',
      name: 'floorNumber',
      desc: '',
      args: [],
    );
  }

  /// `Apartment number`
  String get apartmentNumber {
    return Intl.message(
      'Apartment number',
      name: 'apartmentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get saveAddress {
    return Intl.message(
      'Save Address',
      name: 'saveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal : `
  String get subtotal {
    return Intl.message('Subtotal : ', name: 'subtotal', desc: '', args: []);
  }

  /// `Delivery :`
  String get delivery {
    return Intl.message('Delivery :', name: 'delivery', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Order Now`
  String get orderNow {
    return Intl.message('Order Now', name: 'orderNow', desc: '', args: []);
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message('Pay Now', name: 'payNow', desc: '', args: []);
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
