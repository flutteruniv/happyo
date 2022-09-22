import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/widgets/play_list.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../common/format.dart';
import '../common/routes.dart';
import '../widgets/side_menu.dart';
import '../widgets/youtube_player.dart';

class VideoPlayPage extends StatelessWidget {
  const VideoPlayPage({super.key});

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
      drawer: SideMenu(),
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        )),
                  ],
                ),
                Column(
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.tag!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              '#${movie.tag![index].toString()}',
                              style: MyStyles.font10(context),
                            ),
                          );
                        },
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
                            InkWell(
                              onTap: () {
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
                            InkWell(
                              onTap: () {
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
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('未実装です'),
                                  duration: Duration(milliseconds: 300),
                                ));
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
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('未実装です'),
                                  duration: Duration(milliseconds: 300),
                                ));
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.download),
                                  Text(
                                    'ダウンロード',
                                    style: MyStyles.font10(context),
                                  )
                                ],
                              ),
                            ),
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
                              child: Text('+ フォローする',
                                  style: MyStyles.followButtonText(context)),
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
              ],
            ),
          ),
          const Expanded(child: PlayList()),
        ],
      ),
    );
  }
}
