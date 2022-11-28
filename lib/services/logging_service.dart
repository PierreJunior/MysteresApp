import 'package:sentry_flutter/sentry_flutter.dart';

class LoggingService {
  Future<void> exception(exception, strackTrace,
      [Map<String, dynamic>? context, String? transaction]) async {
    if (context != null) {
      await Sentry.captureException(exception, stackTrace: strackTrace,
          withScope: (scope) {
        scope.setContexts('context', context);
        scope.transaction = transaction;
      });
    } else {
      await Sentry.captureException(exception, stackTrace: strackTrace,
          withScope: (scope) {
        scope.transaction = transaction;
      });
    }
  }

  static Future<void> message(String? message) async {
    await Sentry.captureMessage(message);
  }
}
