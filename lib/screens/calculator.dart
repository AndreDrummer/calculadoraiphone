import 'package:calculator/storage/local_storage.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:calculator/components/display.dart';
import 'package:calculator/ads/ads_manager.dart';
import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  AdsManager adsManager = AdsManager();
  Memory memory = Memory();
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    showRewarded();
  }

  Future<void> showRewarded() async {
    var adShownToday = await LocalStorage.getValueUnderString(
      DateTime.now().toIso8601String().split('T').first,
    );

    bool alreadyShown = adShownToday != null;

    if (!isPremium && !alreadyShown) {
      adsManager.keepTryingShowRewardedAd();
    }
  }

  @override
  void didChangeDependencies() {
    if (!isPremium) {
      createAds();
    }
    super.didChangeDependencies();
  }

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  void createAds() {
    adsManager.createBannerAd();
    adsManager.createRewardedAd();
    adsManager.createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        adsManager.adBannerWidget(),
        SizedBox(height: 35),
        Display(memory.value),
        Keyboard(_onPressed),
      ],
    );
  }

  @override
  void dispose() {
    adsManager.dispose();
    super.dispose();
  }
}
