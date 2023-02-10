import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:calculator/screens/hall_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calculator/ads/ads_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MobileAds.instance.initialize();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AdsManager adsManager = AdsManager();

  @override
  void initState() {
    adsManager.loadAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (_, __) => GetMaterialApp(
        title: 'Calculadora de iPhone',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<void>(
          future: adsManager.loadAds(),
          builder: (context, snapshot) {
            return Stack(
              children: [
                HallScreen(),
                Visibility(
                  visible: snapshot.connectionState == ConnectionState.waiting,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(.7),
                    child: SizedBox(
                      child: CircularProgressIndicator(strokeWidth: 1),
                      height: 40.0.h,
                      width: 40.0.w,
                    ),
                    height: Get.height,
                    width: Get.width,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
