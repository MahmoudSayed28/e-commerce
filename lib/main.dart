import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fruits_app/core/helper/cache_helper.dart';
import 'package:fruits_app/core/helper/custom_observer.dart';
import 'package:fruits_app/core/helper/notification.dart';
import 'package:fruits_app/core/helper/route_method.dart';
import 'package:fruits_app/core/helper/service_locator.dart';
import 'package:fruits_app/core/utils/theme_manager.dart';
import 'package:fruits_app/firebase_options.dart';
import 'package:fruits_app/main_layout.dart';
import 'generated/l10n.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Background Message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 // await SupabaseHelper.setUpSupabase();

  initServiceLocator();
  await CacheHelper.init();
  Bloc.observer = CustomBLocObserver();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const FruitsHub());
  NotificationService().init();
}

class FruitsHub extends StatelessWidget {
  const FruitsHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainLayout(),
      theme: getApplicationTheme(),
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      // initialRoute: SplashView.id,
    );
  }
}
