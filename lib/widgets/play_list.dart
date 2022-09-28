import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/infrastructure/state/play_list_notifier.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayList extends StatefulHookConsumerWidget {
  String? categoryName;

  PlayList({
    super.key,
    this.categoryName,
  });

  @override
  PlayListState createState() => PlayListState();
}

class PlayListState extends ConsumerState<PlayList> {
  List<Movie>? state;
  PlayListNotifier? notifier;
  MovieNotifier? movieNotifier;

  void _fetchPlayList() {
    if (widget.categoryName == null) {
      notifier!.fetchAll();
    } else {
      notifier!.fetchCategorizedPlayList(widget.categoryName!);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchPlayList();
    });
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(playListNotifierProvider);
    notifier = ref.watch(playListNotifierProvider.notifier);
    movieNotifier = ref.watch(movieStateNotifierProvider.notifier);

    return ListView.builder(
      itemCount: state!.length,
      itemBuilder: (BuildContext context, int index) {
        return VideoTile(
            movie: state![index],
            onPressed: () {
              movieNotifier!.set(state![index]);
              Routes.pushNamed(context, Routes.videoPlay);
            });
      },
    );
  }
}
