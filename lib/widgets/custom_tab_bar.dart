import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.tab,
    required this.list,
  }) : super(key: key);

  final List<Tab> tab;
  final List<Widget> list;

  @override
  Widget build(BuildContext context) {
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
}
