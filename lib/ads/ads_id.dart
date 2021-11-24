import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalculatorAdsID {
  static String interstitialId = kDebugMode
      ? InterstitialAd.testAdUnitId
      : 'ca-app-pub-2837828701670824/1879398858';

  static String rewardedId = kDebugMode
      ? RewardedAd.testAdUnitId
      : 'ca-app-pub-2837828701670824/1879398858';

  static String bannerId = kDebugMode
      ? BannerAd.testAdUnitId
      : 'ca-app-pub-2837828701670824/6086139467';
}
