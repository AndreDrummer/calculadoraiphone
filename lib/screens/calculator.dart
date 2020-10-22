import 'package:calculator/components/display.dart';
import 'package:calculator/components/keyboard.dart';
import 'package:calculator/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Memory memory = Memory();
  AdmobBannerSize bannerSize;

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        AdmobBanner(
          adUnitId: 'ca-app-pub-2837828701670824/6086139467',
          adSize: AdmobBannerSize.ADAPTIVE_BANNER(width: MediaQuery.of(context).size.width ~/ 1),
          listener: (AdmobAdEvent event, Map<String, dynamic> args) {},
          onBannerCreated: (AdmobBannerController controller) {},
        ),
        Display(memory.value),
        Keyboard(_onPressed),
      ],
    );
  }
}
