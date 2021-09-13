import 'package:calculator/ads/ads_id.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  int _numInterstitialLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;
  int _numRewardedLoadAttempts = 0;
  InterstitialAd? _interstitialAd;
  late AdWidget bannerAdWidget;
  RewardedAd? _rewardedAd;
  late BannerAd adBanner;

  void createBannerAd() {
    adBanner = BannerAd(
      adUnitId: CalculatorAdsID.bannerId,
      listener: BannerAdListener(),
      request: AdRequest(),
      size: AdSize.banner,
    );
  }

  Container adBannerWidget() {
    adBanner.load();
    return Container(
      height: adBanner.size.height.toDouble(),
      width: adBanner.size.width.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(ad: adBanner),
    );
  }

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: CalculatorAdsID.rewardedId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _numRewardedLoadAttempts = 0;
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
            createRewardedAd();
          }
        },
      ),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      keepTryingShowRewardedAd();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  void keepTryingShowRewardedAd() {
    Future.delayed(Duration(seconds: 3), () {
      _showRewardedAd();
    });
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: CalculatorAdsID.interstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            createInterstitialAd();
          }
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
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void keepTryingShowInterstitialAd() {
    Future.delayed(Duration(seconds: 30), () {
      _showInterstitialAd();
    });
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    adBanner.dispose();
  }
}
