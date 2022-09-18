import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:happyo/infrastructure/movie_repository.dart';

import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayList extends HookConsumerWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(movieRepositoryProvider);

    useEffect(() {
      state.fetchAll();
      return null;
    });

    return ListView.builder(
      itemCount: state.movieList.length,
      itemBuilder: (BuildContext context, int index) {
        return VideoTile(state.movieList[index]);
      },
    );
  }
}
