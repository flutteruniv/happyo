import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/infrastructure/state/play_list_notifier.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayList extends StatefulHookConsumerWidget {
  String? title;

  PlayList({
    super.key,
    this.title,
  });

  @override
  PlayListState createState() => PlayListState();
}

class PlayListState extends ConsumerState<PlayList> {
  List<Movie>? state;
  PlayListNotifier? notifier;
  MovieNotifier? movieNotifier;

  Future<List<Movie>> _fetchPlayList() {
    if (widget.title == null) {
      return notifier!.fetchAll();
    } else {
      return notifier!.fetchCategorizedPlayList(widget.title!);
    }
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(playListNotifierProvider);
    notifier = ref.watch(playListNotifierProvider.notifier);
    movieNotifier = ref.watch(movieStateNotifierProvider.notifier);

    return FutureBuilder<Object>(
        future: _fetchPlayList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data! as List<Movie>;
            if (list.isEmpty) {
              return const Center(child: Text('データが存在しません'));
            } else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoTile(
                      movie: list[index],
                      onPressed: () {
                        movieNotifier!.set(list[index]);
                        Routes.pushNamed(context, Routes.videoPlay);
                      });
                },
              );
            }
          }
          return const Center(child: Text('データ取得中...'));
        });
  }
}
