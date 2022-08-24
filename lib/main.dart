import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.index,
      routes: {
        Routes.index: (context) {
          return HomePage();
        },
      },
    );
  }
}
