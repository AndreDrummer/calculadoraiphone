import 'package:calculator/components/display.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Memory memory = Memory();
  late BannerAd myBanner;
  late AdWidget adWidget;

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  void initState() {
    super.initState();
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-2837828701670824/6086139467',
      listener: BannerAdListener(),
      request: AdRequest(),
      size: AdSize.banner,
    );
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
          height: myBanner.size.height.toDouble(),
          width: myBanner.size.width.toDouble(),
          alignment: Alignment.center,
          child: adWidget,
        ),
        Display(memory.value),
        Keyboard(_onPressed),
      ],
    );
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
}
