import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/repository/movie_repository.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchResultPage extends HookConsumerWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? keyword = Routes.getArgs(context) as String?;
    final movieNotifier = ref.watch(movieStateNotifierProvider.notifier);

    Future<List<Movie>> _search() async {
      return ref.read(movieRepositoryProvider).search(keyword.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            FutureBuilder(
              future: _search(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Movie>> snapshot,
              ) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length >= 1) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return VideoTile(
                          movie: snapshot.data![index],
                          onPressed: () async {
                            final movie = await movieNotifier
                                .findById(snapshot.data![index].id!);
                            movieNotifier.set(movie);
                            Routes.pushNamed(context, Routes.videoPlay);
                          },
                        );
                      },
                    );
                  }
                }
                return const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text('コンテンツが見つかりません。'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
