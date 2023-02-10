import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:calculator/storage/local_storage.dart';
import 'package:flutter/foundation.dart';

class AdsManager {
  RewardedAd? _rewardedAd;

  bool _rewardedAdWasLoaded = false;

  Future<void> loadAds() async {
    await _loadRewardedAd();
  }

  Future<void> _loadRewardedAd() async {
    try {
      await RewardedAd.load(
        adUnitId: 'ca-app-pub-2837828701670824/5452994852',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            debugPrint('RewardedAd $ad loaded.');
            this._rewardedAd = ad;
            _rewardedAdWasLoaded = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ),
      );
    } catch (exception) {
      print('An error ocurred when trying load Rewarded Ad: $exception.');
    }
  }

  Future<bool> _mustShowAd() async {
    final storageKey = DateTime.now().toIso8601String().split('T').first;

    var adShownToday = await LocalStorage.getValueUnderString(storageKey);

    print(storageKey);
    print(adShownToday);

    return adShownToday == null;
  }

  Future<void> showRewardedAd() async {
    if (await _mustShowAd()) {
      if (!_rewardedAdWasLoaded) {
        await _loadRewardedAd();
        _showRewarded();
      } else if (_rewardedAd != null) {
        _showRewarded();
      }
    }
  }

  void _showRewarded() {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => debugPrint('$ad impression occurred.'),
    );

    _rewardedAd?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        ad.dispose();
        if (kDebugMode) debugPrint('TiuTiuApp: Usuário assistiu certinho ${ad.adUnitId} ${rewardItem.amount}');

        await LocalStorage.clearStorage();

        final todayDate = DateTime.now();

        final storageKey = todayDate.toIso8601String().split('T').first;

        print('showOpening $storageKey');

        LocalStorage.setValueUnderString(key: storageKey, value: storageKey);
      },
    ).then((_) => _rewardedAdWasLoaded = false);
  }
}
