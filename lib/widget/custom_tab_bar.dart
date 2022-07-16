import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  CustomTabBar({
    Key? key,
  }) : super(key: key);

  final _tab = <Tab>[
    Tab(text: 'ネットワーク'),
    Tab(text: 'おすすめ'),
    Tab(text: 'セキュリティ'),
    Tab(text: 'AI'),
    Tab(text: 'AI2'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: _tab.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            tabs: _tab,
          ),
          backgroundColor: Colors.black,
        ),
        body: const TabBarView(
          children: <Widget>[
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
      ),
    );
  }
}
