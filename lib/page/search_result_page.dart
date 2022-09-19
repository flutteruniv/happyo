import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? keyword = Routes.getArgs(context) as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            color: Theme.of(context).colorScheme.secondaryContainer,
            width: double.infinity,
            child: Text(
              "検索ワード : $keyword",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
