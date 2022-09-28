import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/infrastructure/state/play_list_notifier.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyListPage extends StatefulHookConsumerWidget {
  @override
  MyListPageState createState() => MyListPageState();
}

class MyListPageState extends ConsumerState<MyListPage> {
  List<Movie>? state;
  PlayListNotifier? notifier;
  MovieNotifier? movieNotifier;

  @override
  Widget build(BuildContext context) {
    state = ref.watch(playListNotifierProvider);
    notifier = ref.watch(playListNotifierProvider.notifier);
    movieNotifier = ref.watch(movieStateNotifierProvider.notifier);

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
      body: FutureBuilder<Object>(
        future: notifier?.fetchMyList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data as List<Movie>;
            if (list.isEmpty) {
              return const Center(
                child: Text(
                  'マイリストに登録されたコンテンツがありません',
                ),
              );
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // title: Text('確認'),
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          content: const Text('マイリストから削除します。よろしいですか？'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('キャンセル')),
                            TextButton(
                              onPressed: () async {
                                notifier!.removeMovieFromUsersMovieList(
                                    'MyList', list[index]);
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                '削除',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 32),
                    color: Theme.of(context).colorScheme.error,
                    child: const Icon(Icons.delete_forever_rounded),
                  ),
                  child: VideoTile(
                      movie: list[index],
                      onPressed: () {
                        movieNotifier!.set(list[index]);
                        Routes.pushNamed(context, Routes.videoPlay);
                      }),
                );
              },
            );
          }
          return const Center(
            child: Text(
              'マイリストを取得中です',
            ),
          );
        },
      ),
    );
  }
}
