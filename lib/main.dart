import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/login/login_widget_export.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import 'package:prefs/prefs.dart';

void main() async {

  Prefs.init();

  bool isInDebugMode = true;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    Firestore.instance.settings(persistenceEnabled: true, cacheSizeBytes: 10000000);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MONEY MANAGER',
      theme: getAppTheme(),
      home: LoginWidget(),
      supportedLocales: [
        const Locale('vi'), // English
        const Locale('en'), // Japan
      ],
      localizationsDelegates: [
        const MoneyManagerLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

    );
  }
}
