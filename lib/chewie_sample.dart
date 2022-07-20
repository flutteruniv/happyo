import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class ChewieSample extends StatefulWidget {
  const ChewieSample({Key? key}) : super(key: key);

  @override
  _ChewieSample createState() => _ChewieSample();
}

class _ChewieSample extends State<ChewieSample> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        'https://d1z7r4ej4jf82p.cloudfront.net/sample.m3u8');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      // aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:
      // showControls: true,
      //シークバーの色の調整
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        // bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chewie Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chewie Sample'),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _videoPlayerController.value.isPlaying
                  ? _chewieController.pause()
                  : _chewieController.play();
            });
          },
          child: Icon(
            _videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
