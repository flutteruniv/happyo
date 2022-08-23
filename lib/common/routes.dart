import 'package:flutter/material.dart';

class Routes {
  static const String index = '/';

  static void pushNamed(BuildContext context, String routeName,
      {Object? args}) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static dynamic getArgs(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments;
  }
}
