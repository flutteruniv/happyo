import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/widgets/custom_tab_bar.dart';
import 'package:happyo/widgets/play_list.dart';
import 'package:happyo/widgets/side_menu.dart';

import '../widgets/video_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'HAPPY',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              'O',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 10,
          //     horizontal: 12,
          //   ),
          //   child: TextButton(
          //     onPressed: () {
          //       Routes.pushNamed(context, Routes.eventCreate);
          //     },
          //     child: const Text('イベント作成'),
          //   ),
          // ),
          IconButton(
            onPressed: () {
              Routes.pushNamed(context, Routes.search);
            },
            icon: const Icon(Icons.search),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      // drawer: SideMenu(),
      body: CustomTabBar(
        tabs: [
          Tab(text: 'ビデオタイル'),
          Tab(text: 'ネットワーク'),
          Tab(text: 'おすすめ'),
          Tab(text: 'セキュリティ'),
          Tab(text: 'AI'),
          Tab(text: 'AI2'),
        ],
        list: [
          PlayList(),
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
