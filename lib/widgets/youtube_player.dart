import 'package:flutter/material.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayer extends StatelessWidget {
  static const String urlPrefix = "https://www.youtube.com/watch?v=";
  late String videoId;
  YouTubePlayer({Key? key, required Movie movie}) : super(key: key) {
    videoId = extractYouTubeId(movie.streamingUrl!);
  }

  @override
  Widget build(BuildContext context) {
    var ytcl = YoutubePlayerController(
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

  String extractYouTubeId(String url) {
    return url.replaceFirst(urlPrefix, '');
  }
}
