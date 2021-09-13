import 'package:calculator/ads/ads_manager.dart';
import 'package:calculator/components/display.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  AdsManager adsManager = AdsManager();
  Memory memory = Memory();
  bool isPremium = true;

  @override
  void initState() {
    super.initState();
    if (!isPremium) {
      loadAds();
    }
  }

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  void loadAds() {
    adsManager.createBannerAd();
    adsManager.createRewardedAd();
    adsManager.keepTryingShowRewardedAd();
    adsManager.createInterstitialAd();
    adsManager.keepTryingShowInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Container(
            child: !isPremium ? adsManager.adBannerWidget() : Container(),
          ),
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
