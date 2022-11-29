import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/env.dart';
import 'package:mysteres/services/logging_service.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitID =>
      Platform.isAndroid ? Env.bannerAdUnitAndroidID : Env.bannerAdUnitIosID;

  final BannerAdListener bannerListener = BannerAdListener(
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) async {
      // Dispose the ad here to free resources.
      ad.dispose();
      await LoggingService.message('Ad failed to load: $error',
          level: LoggingLevel.error,
          transction: "AdState.BannerAdListener.onAdFailedToLoad");
    },
  );
}

class InterstitialAdState {
  String get interstitialAdUnitId => Platform.isAndroid
      ? Env.interstitialAdUnitAndroidID
      : Env.interstitialAdUnitIosID;

  final BannerAdListener bannerListener = BannerAdListener(
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) async {
      // Dispose the ad here to free resources.
      ad.dispose();
      await LoggingService.message('Interstitial Ad failed to load: $error',
          level: LoggingLevel.error,
          transction: "InterstitialAdState.BannerAdListener.onAdFailedToLoad");
    },
  );
}

class ShowInterstitial {
  bool isAdLoaded = false;
  late InterstitialAd? interstitial;

  void showInterstitialAd() {
    if (interstitial != null) {
      interstitial!.fullScreenContentCallback = FullScreenContentCallback(
        onAdFailedToShowFullScreenContent: (ad, error) async {
          ad.dispose();
          await LoggingService.message('Ad failed to load: $error',
              level: LoggingLevel.error,
              transction:
                  "ShowInterstitial.showInterstitialAd.onAdFailedToShowFullScreenContent");
          createInterstitialAd();
        },
      );
      interstitial!.show();
      interstitial = null;
    }
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAdState().interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: onAdLoaded,
            onAdFailedToLoad: (LoadAdError error) async {
              await LoggingService.message('Ad failed to load: $error',
                  level: LoggingLevel.error,
                  transction:
                      "ShowInterstitial.createInterstitialAd.onAdFailedToLoad");
            }));
  }

  void onAdLoaded(InterstitialAd ad) {
    interstitial = ad;
    isAdLoaded = true;
  }
}
