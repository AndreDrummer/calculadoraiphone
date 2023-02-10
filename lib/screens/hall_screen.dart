import 'package:calculator/screens/calculator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/ads/banner_widget.dart';
import 'package:calculator/ads/ads_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class HallScreen extends StatefulWidget {
  HallScreen({super.key});

  @override
  State<HallScreen> createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  final AdsManager adsManager = AdsManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdBanner(
              adId: 'ca-app-pub-2837828701670824/7674181122',
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  adsManager.showRewardedAd().then((value) => Get.to(Calculator()));
                });
              },
              child: AutoSizeText(
                'OPEN CALCULATOR',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: AutoSizeText(
                'EXIT',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(),
            AdBanner(adId: 'ca-app-pub-2837828701670824/1485829686'),
          ],
        ),
      ),
    );
  }
}
