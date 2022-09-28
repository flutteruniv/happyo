import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/repository/master_repository.dart';
import 'package:happyo/widgets/custom_tab_bar.dart';
import 'package:happyo/widgets/play_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = MasterRepository.instance.master.categories;

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
          for (final cateogry in categories) Tab(text: cateogry),
        ],
        list: [
          for (final cateogry in categories) PlayList(categoryName: cateogry),
        ],
      ),
    );
  }
}
