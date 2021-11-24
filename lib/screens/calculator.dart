import 'package:calculator/ads/ads_manager.dart';
import 'package:calculator/components/display.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:calculator/main.dart';
import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  AdsManager adsManager = AdsManager();
  Memory memory = Memory();

  @override
  void didChangeDependencies() {
    if (!isPremium) {
      createAds();
    }
    super.didChangeDependencies();
  }

  void _onPressed(String command) {
    if (command == '=') loadProgramaticallyAds();
    setState(() {
      memory.applyCommand(command);
    });
  }

  void createAds() {
    adsManager.createBannerAd();
    adsManager.createRewardedAd();
    adsManager.createInterstitialAd();
  }

  void loadProgramaticallyAds() {
    if (DateTime.now().minute % 5 == 0) {
      adsManager.keepTryingShowRewardedAd();
    } else if (DateTime.now().minute % 2 == 0) {
      adsManager.keepTryingShowInterstitialAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }

  @override
  void dispose() {
    adsManager.dispose();
    super.dispose();
  }
}
