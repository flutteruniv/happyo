import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/infrastructure/state/play_list_notifier.dart';
import 'package:happyo/widgets/video_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayList extends HookConsumerWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playListNotifierProvider);
    final notifier = ref.watch(playListNotifierProvider.notifier);
    final movieNotifier = ref.watch(movieStateNotifierProvider.notifier);

    notifier.fetchAll();

    return ListView.builder(
      itemCount: state!.length,
      itemBuilder: (BuildContext context, int index) {
        return VideoTile(state[index], onPressed: () {
          movieNotifier.set(state[index]);
          Routes.pushNamed(context, Routes.videoPlay);
        });
      },
    );
  }
}
