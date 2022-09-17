import 'package:flutter/material.dart';
import 'package:happyo/widgets/video_tile.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 34,
      itemBuilder: (BuildContext context, int index) {
        return const VideoTile();
      },
    );
  }
}
