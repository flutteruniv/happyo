import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.background,
      leading:
          Image.network('https://i.ytimg.com/vi/PXnqg_Ozouk/maxresdefault.jpg'),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('タイトルタイトルタイトルタイトルタイトルタイトル',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            const Text(
              'チャンネル名',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 14,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: Text(
                      '#dasta',
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          //アイコンがリストタイルの中央に配置
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LineIcons.youtube),
          ],
        ),
      ),
    );
  }
}
