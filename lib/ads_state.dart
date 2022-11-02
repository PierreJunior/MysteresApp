import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/env.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitID =>
      Platform.isAndroid ? Env.bannerAdUnitAndroidID : Env.bannerAdUnitIosID;

  final BannerAdListener bannerListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

class InterstitialAdState {
  String get interstitialAdUnitId => Platform.isAndroid
      ? Env.interstitialAdUnitAndroidID
      : Env.interstitialAdUnitIosID;

  final BannerAdListener bannerListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

class ShowInterstitial {
  bool isAdLoaded = false;
  late InterstitialAd? interstitial;

  void showInterstitialAd() {
    if (interstitial != null) {
      interstitial!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('ad showed'),
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
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
            onAdFailedToLoad: (LoadAdError error) =>
                print("Interstitial Ad Failed to Load")));
  }

  void onAdLoaded(InterstitialAd ad) {
    print("interstatial Ad Loaded");
    interstitial = ad;
    isAdLoaded = true;
  }
}
