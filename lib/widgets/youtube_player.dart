import 'package:flutter/material.dart';
import '../widgets/custom_tab_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayer extends StatelessWidget {
  const YouTubePlayer({Key? key, required this.videoId}) : super(key: key);

  //YouTube動画のID
  final String videoId;

  @override
  Widget build(BuildContext context) {
    var ytcl = YoutubePlayerController(
      // initialVideoId: 'I6TpDuSFbTc',
      initialVideoId: videoId,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return YoutubePlayerControllerProvider(
      controller: ytcl,
      child: const YoutubePlayerIFrame(),
    );
  }
}
