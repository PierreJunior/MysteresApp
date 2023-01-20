import 'package:flutter/services.dart';

/// Wraps a method channel that makes calls to AppLovin privacy APIs.
class MyMethodChannel {
  final MethodChannel _methodChannel =
  const MethodChannel('com.kalani.rosary/mediation-channel');

  /// Sets whether the user is age restricted in AppLovin.
  Future<void> setAppLovinIsAgeRestrictedUser(bool isAgeRestricted) async {
    return _methodChannel.invokeMethod(
      'setIsAgeRestrictedUser',
      {
        'isAgeRestricted': isAgeRestricted,
      },
    );
  }

  /// Sets whether we have user consent for the user in AppLovin.
  Future<void> setHasUserConsent(bool hasUserConsent) async {
    return _methodChannel.invokeMethod(
      'setHasUserConsent',
      {
        'hasUserConsent': hasUserConsent,
      },
    );
  }
}