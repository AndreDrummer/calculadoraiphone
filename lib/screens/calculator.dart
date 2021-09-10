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
  final int maxFailedLoadAttempts = 3;
  int _numRewardedLoadAttempts = 0;

  late AdWidget bannerAdWidget;
  RewardedAd? _rewardedAd;

  Memory memory = Memory();
  late BannerAd adBanner;

  void _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  @override
  void initState() {
    super.initState();
    adBanner = BannerAd(
      adUnitId: 'ca-app-pub-2837828701670824/6086139467',
      listener: BannerAdListener(),
      request: AdRequest(),
      size: AdSize.banner,
    );
    adBanner.load();
    bannerAdWidget = AdWidget(ad: adBanner);
    _createRewardedAd();
    tryShowRewardedAd();
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-2837828701670824/1879398858',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
            _createRewardedAd();
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      tryShowRewardedAd();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  void tryShowRewardedAd() {
    Future.delayed(Duration(seconds: 3), () {
      _showRewardedAd();
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
            height: adBanner.size.height.toDouble(),
            width: adBanner.size.width.toDouble(),
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
    _rewardedAd?.dispose();
    adBanner.dispose();
    super.dispose();
  }
}
