import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({
    required this.adId,
    this.height,
    this.margin,
    super.key,
  });

  final EdgeInsetsGeometry? margin;
  final String adId;
  final int? height;

  @override
  State<AdBanner> createState() => _AdBanner300x60State();
}

class _AdBanner300x60State extends State<AdBanner> {
  bool _bannerAdFailedToLoad = false;
  late BannerAd _bannerAd;

  @override
  void initState() {
    final size = AnchoredAdaptiveBannerAdSize(
      height: widget.height ?? 56,
      width: Get.width.toInt(),
      Orientation.landscape,
    );

    _bannerAd = BannerAd(
      listener: bannerAdListener(onAdLoaded: (ad) {
        if (kDebugMode) debugPrint('Banner Ad ${ad.adUnitId} Load.');
        _bannerAdFailedToLoad = false;
      }, onAdFailedToLoad: (ad, error) {
        if (kDebugMode) debugPrint('Banner Ad ${ad.adUnitId} Failed to load: $error');
        _bannerAdFailedToLoad = true;
      }),
      request: AdRequest(),
      adUnitId: widget.adId,
      size: size,
    );

    _bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_bannerAdFailedToLoad,
      child: Container(
        margin: widget.margin ?? EdgeInsets.zero,
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: AdWidget(ad: _bannerAd),
        ),
      ),
    );
  }

  BannerAdListener bannerAdListener({
    void Function(Ad ad, LoadAdError error)? onAdFailedToLoad,
    void Function(Ad)? onAdImpression,
    void Function(Ad)? onAdOpened,
    void Function(Ad)? onAdClosed,
    void Function(Ad)? onAdLoaded,
  }) {
    return BannerAdListener(
      onAdFailedToLoad: onAdFailedToLoad,
      onAdImpression: onAdImpression,
      onAdLoaded: onAdLoaded,
      onAdOpened: onAdOpened,
      onAdClosed: onAdClosed,
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}
