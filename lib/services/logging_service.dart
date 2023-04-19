import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoggingService {
  static Future<void> exception(exception, strackTrace,
      {Map<String, dynamic>? context, String? transaction}) async {
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

  static Future<void> message(String? message,
      {LoggingLevel? level = LoggingLevel.info, String? transction}) async {
    SentryLevel logLevel;
    switch (level) {
      case LoggingLevel.debug:
        {
          logLevel = SentryLevel.debug;
        }
        break;
      case LoggingLevel.info:
        {
          logLevel = SentryLevel.info;
        }
        break;
      case LoggingLevel.warn:
        {
          logLevel = SentryLevel.warning;
        }
        break;
      case LoggingLevel.error:
        {
          logLevel = SentryLevel.error;
        }
        break;
      case LoggingLevel.fatal:
        {
          logLevel = SentryLevel.fatal;
        }
        break;
      default:
        {
          logLevel = SentryLevel.info;
        }
    }
    await Sentry.captureMessage(message, withScope: (scope) {
      scope.level = logLevel;
    });
  }

  static debug(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

enum LoggingLevel { debug, info, warn, error, fatal }
