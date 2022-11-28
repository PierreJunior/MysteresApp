abstract class Env {
  // START AD UNIT VARIABLES
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
  // END AD UNIT VARIABLES

  // START FIREBASE VARIABLES
  static const String firebaseAndroidApiKey = String.fromEnvironment(
    'FIREBASE_ANDROID_API_KEY',
    defaultValue: '',
  );

  static const String firebaseAndroidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
    defaultValue: '',
  );

  static const String firebaseStorageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
    defaultValue: '',
  );

  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: '',
  );

  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: '',
  );

  static const String firebaseDatabaseURL = String.fromEnvironment(
    'FIREBASE_DATABASE_URL',
    defaultValue: '',
  );

  static const String firebaseIosClientId = String.fromEnvironment(
    'FIREBASE_IOS_CLIENT_ID',
    defaultValue: '',
  );

  static const String firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: '',
  );

  static const String firebaseIosApiKey = String.fromEnvironment(
    'FIREBASE_IOS_API_KEY',
    defaultValue: '',
  );

  static const String firebaseIosAppId = String.fromEnvironment(
    'FIREBASE_IOS_APP_ID',
    defaultValue: '',
  );
  // END FIREBASE VARIABLES

  // START SENTRY VARIABLES
  static const String sentryDSN = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue: '',
  );

  /// Must be a number between 0 and 1. (For example, to send 20% of
  /// transactions, set the value to 0.2.)
  static const String sentryTraceSampleRate =
      String.fromEnvironment('SENTRY_TRACE_SAMPLE_RATE', defaultValue: "0.1");
  // END SENTRY VARIABLES
}
