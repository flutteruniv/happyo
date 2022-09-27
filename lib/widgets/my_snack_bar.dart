import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  MySnackBar({
    Key? key,
    required BuildContext context,
    String? message,
    Duration? duration,
  }) : super(
          key: key,
          content: Text(
            "$message",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          duration: duration ?? const Duration(seconds: 1),
          backgroundColor: Theme.of(context).colorScheme.background,
        );
}
