import 'package:sentry_flutter/sentry_flutter.dart';

class LoggingService {
  Future<void> exception(e, s) async {
    await Sentry.captureException(
      e,
      stackTrace: s,
    );
  }

  static Future<void> message(String? message) async {
    await Sentry.captureMessage(message);
  }
}
