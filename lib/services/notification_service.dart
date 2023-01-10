import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';

class NotificationService {
  static Flushbar getFlushbar(String message, int duration, Color color,
      NotificationPosition position) {
    Map<NotificationPosition, FlushbarPosition> positionMap = {
      NotificationPosition.TOP: FlushbarPosition.TOP,
      NotificationPosition.BOTTOM: FlushbarPosition.BOTTOM
    };
    return Flushbar(
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: duration),
      flushbarPosition: positionMap[position] ?? FlushbarPosition.BOTTOM,
    );
  }
}

enum NotificationPosition { TOP, BOTTOM }
