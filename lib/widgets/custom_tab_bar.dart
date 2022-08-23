import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> list;
  final int initialIndex;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.list,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Center(
            child: TabBar(
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              tabs: tabs,
            ),
          ),
        ),
        body: TabBarView(
          children: list,
        ),
      ),
    );
  }
}
