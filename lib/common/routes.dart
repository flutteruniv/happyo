import 'package:flutter/material.dart';
import 'package:happyo/page/event/event_create_page.dart';
import 'package:happyo/page/home_page.dart';
import 'package:happyo/page/settings/settings_page.dart';
import 'package:happyo/page/seach_page.dart';
import 'package:happyo/page/search_result_page.dart';
import 'package:happyo/page/video_play_page.dart';
import 'package:happyo/widgets/custom_nav_bar.dart';

abstract class Routes {
  static const String home = '/home';
  static const String index = '/';
  static const String profile = 'profile';
  static const String search = 'search';
  static const String searchResult = 'search/result';
  static const String eventCreate = 'event/create';
  static const String videoPlay = 'videoPlay';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      index: (context) {
        return CustomNavBar();
      },
      home: (context) {
        return HomePage();
      },
      profile: (context) {
        return ProfilePage();
      },
      search: (context) {
        return SearchPage();
      },
      searchResult: (context) {
        return SearchResultPage();
      },
      eventCreate: (context) {
        return EventCreatePage();
      },
      videoPlay: (context) {
        return VideoPlayPage();
      },
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
