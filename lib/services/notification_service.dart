import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';

class NotificationService {
  static Flushbar getFlushbar(
      {required String message,
      int duration = 5,
      required Color color,
      NotificationPosition position = NotificationPosition.bottom}) {
    Map<NotificationPosition, FlushbarPosition> positionMap = {
      NotificationPosition.top: FlushbarPosition.TOP,
      NotificationPosition.bottom: FlushbarPosition.BOTTOM
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

enum NotificationPosition { top, bottom }
