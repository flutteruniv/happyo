import 'package:flutter/material.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/model/movie/movie_platform.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoTile extends HookConsumerWidget {
  final Movie movie;
  void Function()? onPressed;

  VideoTile({super.key, required this.onPressed, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        onPressed?.call();
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 0),
              child: SizedBox(
                height: 88,
                width: 144,
                child: Image.network(
                  movie.thumbnailImage.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title.toString(),
                              maxLines: 3,
                              style: MyStyles.tileTitleText(context)),
                          Text(
                            movie.hostName.toString(),
                            maxLines: 1,
                            style: MyStyles.font10(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (movie.tagList != null)
                            for (var tag in movie.tagList!)
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  '#${tag!.toString()}',
                                  style: MyStyles.tileTagNameText(context),
                                ),
                              ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      movie.platform == MoviePlatform.happyo
                          ? const Icon(Icons.download_rounded)
                          : Column(
                              children: [
                                Column(
                                  children: const [
                                    Text('You', style: TextStyle(fontSize: 9)),
                                    Text('Tube', style: TextStyle(fontSize: 9)),
                                  ],
                                ),
                              ],
                            ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
