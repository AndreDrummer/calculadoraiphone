import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import "package:calculator/screens/calculator.dart";
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  FirebaseAdMob.instance
      .initialize(appId: 'ca-app-pub-2837828701670824~6493333574');
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
       if (snapshot.hasError) {
          return Directionality(
            child: MediaQuery(
              data: MediaQueryData(),
              child: Center(child: Text('${snapshot.error}')),
            ),
            textDirection: TextDirection.ltr,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorObservers: <NavigatorObserver>[observer],
            title: 'Calculadora de iPhone',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: Calculator(),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
