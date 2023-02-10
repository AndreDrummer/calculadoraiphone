import 'package:calculator/components/keyboard.dart';
import 'package:calculator/components/display.dart';
import 'package:calculator/ads/banner_widget.dart';
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

  @override
  void initState() {
    adsManager.showRewardedAd();
    super.initState();
  }

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AdBanner(adId: 'ca-app-pub-2837828701670824/7674181122'),
          SizedBox(height: 35),
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }
}
