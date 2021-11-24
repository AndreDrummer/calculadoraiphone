import 'package:calculator/ads/ads_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import "package:calculator/screens/calculator.dart";
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

bool isPremium = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AdsManager adsManager = AdsManager();

  if (!isPremium) {
    adsManager.createRewardedAd();
    adsManager.createInterstitialAd();
    adsManager.keepTryingShowRewardedAd();
  }
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
          return ScreenUtilInit(
            designSize: Size(360, 690),
            builder: () => MaterialApp(
              navigatorObservers: <NavigatorObserver>[observer],
              title: 'Calculadora de iPhone',
              theme: ThemeData(
                primarySwatch: Colors.orange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home: Calculator(),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
