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
  InterstitialAd? _interstitialAd;
  late AdWidget bannerAdWidget;
  Memory memory = Memory();
  late BannerAd myBanner;

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }
// Interstitial

  @override
  void initState() {
    super.initState();
    myBanner = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', //'ca-app-pub-2837828701670824/6086139467',
      listener: BannerAdListener(),
      request: AdRequest(),
      size: AdSize.banner,
    );
    myBanner.load();
    bannerAdWidget = AdWidget(ad: myBanner);
    _createInterstitialAd();
    waitToShowInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          this._interstitialAd = ad;
          print(' ${_interstitialAd?.adUnitId} InterstitialAd');
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void waitToShowInterstitialAd() {
    Future.delayed(Duration(seconds: 3), () {
      _showInterstitialAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 35),
          Container(
            height: myBanner.size.height.toDouble(),
            width: myBanner.size.width.toDouble(),
            alignment: Alignment.center,
            child: bannerAdWidget,
          ),
          Display(memory.value),
          Keyboard(_onPressed),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
}
