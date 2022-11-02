abstract class Env {
  static const String bannerAdUnitAndroidID = String.fromEnvironment(
    'AD_BANNER_ANDROID_UNIT_ID',
    defaultValue: '',
  );

  static const String bannerAdUnitIosID = String.fromEnvironment(
    'AD_BANNER_IOS_UNIT_ID',
    defaultValue: '',
  );

  static const String interstitialAdUnitAndroidID = String.fromEnvironment(
    'AD_INTERSTITIAL_ANDROID_UNIT_ID',
    defaultValue: '',
  );

  static const String interstitialAdUnitIosID = String.fromEnvironment(
    'AD_INTERSTITIAL_IOS_UNIT_ID',
    defaultValue: '',
  );
}
