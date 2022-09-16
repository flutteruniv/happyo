import 'package:flutter/material.dart';
import 'package:happyo/page/home_page.dart';
import 'package:happyo/page/profile/profile_page.dart';
import 'package:happyo/page/seach_page.dart';

abstract class Routes {
  static const String index = '/';
  static const String profile = 'profile';
  static const String search = 'search';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      index: (context) {
        return HomePage();
      },
      profile: (context) {
        return ProfilePage();
      },
      search: (context) {
        return SearchPage();
      }
    };
  }

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
