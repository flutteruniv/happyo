import 'package:flutter/material.dart';

import 'widgets/custom_tab_bar.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
        tab: [
          Tab(text: 'ネットワーク'),
          Tab(text: 'おすすめ'),
          Tab(text: 'セキュリティ'),
          Tab(text: 'AI'),
          Tab(text: 'AI2'),
        ],
        list: [
          Center(
            child: Text('ネットワーク', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('おすすめ', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('セキュリティ', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('AI', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('AI2', style: TextStyle(fontSize: 32.0)),
          ),
        ],
      ),
    );
  }
}
