import 'package:flutter/material.dart';
import 'package:happyo/common/my_syles.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class VideoTile extends HookConsumerWidget {
  const VideoTile(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 0),
            child: SizedBox(
              height: 88,
              width: 144,
              child: Image.network(
                'http://img.youtube.com/vi/${movie.youtubeId.toString()}/mqdefault.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.background,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title.toString(),
                        maxLines: 3, style: MyStyles.tileTitleText(context)),
                    Text(
                      movie.hostName.toString(),
                      maxLines: 1,
                      style: MyStyles.tileHostNameText(context),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 14,
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
                              style: MyStyles.tileTagNameText(context),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              trailing: Column(
                //アイコンがリストタイルの中央に配置
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // videoHolder (0:Happyo, 1:YouTube)
                  movie.videoHolder == 0
                      ? const Icon(Icons.movie)
                      : const Icon(LineIcons.youtube),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
