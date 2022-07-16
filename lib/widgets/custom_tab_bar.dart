import 'package:flutter/material.dart';

Widget CustomTabBar(List<Tab> tab, List<Widget> list) {
  return DefaultTabController(
    initialIndex: 0, // 最初に表示するタブ
    length: tab.length,
    child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          tabs: tab,
        ),
        backgroundColor: Colors.black,
      ),
      body: TabBarView(
        children: list,
      ),
    ),
  );
}
