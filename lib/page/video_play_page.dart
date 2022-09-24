import 'package:flutter/material.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/model/movie/movie_platform.dart';
import 'package:happyo/widgets/play_list.dart';
import 'package:happyo/widgets/youtube_player.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class VideoPlayPage extends StatefulWidget {
  const VideoPlayPage({super.key});

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  bool isVisible = true;

  void toggleShowText() {
    isVisible = !isVisible;
  }

  @override
  Widget build(BuildContext context) {
    Movie? movie = Routes.getArgs(context);
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: TextButton(
              onPressed: () {
                Routes.pushNamed(context, Routes.eventCreate);
              },
              child: const Text('イベント作成'),
            ),
          ),
          IconButton(
            onPressed: () {
              Routes.pushNamed(context, Routes.search);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YouTubePlayer(
            videoId: '${movie!.youtubeId}',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${movie.title}',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.topRight,
                      onPressed: () {
                        setState(
                          () {
                            toggleShowText();
                          },
                        );
                      },
                      icon: isVisible
                          ? const Icon(Icons.keyboard_arrow_down, size: 20)
                          : const Icon(Icons.keyboard_arrow_up, size: 20),
                    ),
                  ],
                ),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${movie.views}回視聴',
                            style: MyStyles.font10(context),
                          ),
                          Text(
                            DateFormat(Format.DATETIME_YYYYMMDDHHMM)
                                .format(movie.postedAt!),
                            style: MyStyles.font10(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                        child: Row(
                          children: [
                            if (movie.tag != null)
                              for (var tag in movie.tag!)
                                Text(
                                  '#${tag.toString()}',
                                  style: MyStyles.font10(context),
                                ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('未実装です'),
                                    duration: Duration(milliseconds: 300),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    const Icon(Icons.thumb_up),
                                    Text(
                                      '${movie.likes}',
                                      style: MyStyles.font10(context),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('未実装です'),
                                    duration: Duration(milliseconds: 300),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    const Icon(Icons.add),
                                    Text(
                                      'マイリスト',
                                      style: MyStyles.font10(context),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Share.share(
                                    "https://m.youtube.com/watch?v=${movie.youtubeId.toString()}",
                                    subject: movie.title,
                                  );
                                },
                                child: Column(
                                  children: [
                                    const Icon(Icons.share),
                                    Text(
                                      '共有',
                                      style: MyStyles.font10(context),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    movie.moviePlatform == MoviePlatform.happyo
                                        ? () {
                                            // TODO: 未実装
                                          }
                                        : null,
                                child: Column(
                                  children: [
                                    const Icon(Icons.download),
                                    Text(
                                      'ダウンロード',
                                      style: MyStyles.font10(context),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO : チャンネルプロフィール画像取得、表示
                            // const CircleAvatar(
                            //   backgroundImage: null,
                            // ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('未実装です'),
                                  duration: Duration(milliseconds: 300),
                                ));
                              },
                              child: Text(
                                '${movie.hostName}',
                                style: MyStyles.hostText(context),
                              ),
                            ),
                            if (movie.moviePlatform == MoviePlatform.happyo)
                              SizedBox(
                                height: 16,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 8,
                                    ),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('未実装です'),
                                      duration: Duration(milliseconds: 300),
                                    ));
                                  },
                                  child: Text(
                                    '+ フォローする',
                                    style: MyStyles.followButtonText(context),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(0),
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: PlayList()),
        ],
      ),
    );
  }
}
