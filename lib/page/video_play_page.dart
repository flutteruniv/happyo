import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/infrastructure/state/movie_state_notifier_provider.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/model/movie/movie_platform.dart';
import 'package:happyo/widgets/play_list.dart';
import 'package:happyo/widgets/youtube_player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class VideoPlayPage extends StatefulHookConsumerWidget {
  bool showDescription;

  VideoPlayPage({super.key, this.showDescription = true});

  @override
  ConsumerState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends ConsumerState<VideoPlayPage> {
  // bool isLike = false;
  late Movie movieState;
  late MovieNotifier movieNotifier;

  void toggleShowText() {
    widget.showDescription = !widget.showDescription;
  }

  @override
  Widget build(BuildContext context) {
    movieState = ref.watch(movieStateNotifierProvider)!;
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YouTubePlayer(
            movie: movieState,
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
                        movieState.title.toString(),
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
                        setState(() {
                          toggleShowText();
                        });
                      },
                      icon: widget.showDescription
                          ? const Icon(Icons.keyboard_arrow_down, size: 20)
                          : const Icon(Icons.keyboard_arrow_up, size: 20),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.showDescription,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${movieState.views}回視聴',
                            style: MyStyles.font10(context),
                          ),
                          Text(
                            DateFormat(Format.DATETIME_YYYYMMDDHHMM)
                                .format(movieState.createdAt!),
                            style: MyStyles.font10(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                        child: Row(
                          children: [
                            if (movieState.tagList != null)
                              for (var tag in movieState.tagList!)
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
                              FutureBuilder(
                                future: movieNotifier.isLike(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data as bool) {
                                      return TextButton(
                                        onPressed: () async {
                                          if (FirebaseAuth
                                                  .instance.currentUser !=
                                              null) {
                                            onUnlike(movieState);
                                            setState(() {});
                                          } else {
                                            // TODO: 未ログインの処理
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.thumb_up_alt,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                            Text(
                                              '${movieState.likes}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontSize:
                                                    MyStyles.font10(context)
                                                        .fontSize,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                  return TextButton(
                                    onPressed: () async {
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        onLike(movieState);
                                        setState(() {});
                                      } else {
                                        // TODO: 未ログインの処理
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        const Icon(Icons.thumb_up_alt_outlined),
                                        Text(
                                          movieState.likes.toString(),
                                          style: MyStyles.font10(context),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    // TODO: マイリストの処理
                                  } else {
                                    // TODO: 未ログインの処理
                                  }
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
                                    movieState.streamingUrl.toString(),
                                    subject: movieState.title,
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
                                    movieState.platform == MoviePlatform.happyo
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
                                movieState.hostName.toString(),
                                style: MyStyles.hostText(context),
                              ),
                            ),
                            if (movieState.platform == MoviePlatform.happyo)
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

  void onLike(Movie movie) async {
    switch (movie.platform) {
      case MoviePlatform.youtube:
        // ref.read(movieStateNotifierProvider.notifier).like();
        movieNotifier.like();
        break;
      case MoviePlatform.happyo:
        // TODO: Handle this case.
        break;
      default:
        // ref.read(movieStateNotifierProvider.notifier).like();
        movieNotifier.like();
        break;
    }
  }

  void onUnlike(Movie movie) async {
    switch (movie.platform) {
      case MoviePlatform.youtube:
        // ref.read(movieStateNotifierProvider.notifier).unLike();
        movieNotifier.unLike();
        break;
      case MoviePlatform.happyo:
        // TODO: Handle this case.
        break;
      default:
        // ref.read(movieStateNotifierProvider.notifier).unLike();
        movieNotifier.unLike();
        break;
    }
  }
}
