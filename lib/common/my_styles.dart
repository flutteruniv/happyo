import 'package:flutter/material.dart';

abstract class MyStyles {
  static TextStyle defaultText(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  // ビデオタイルの動画タイトルテキスト
  static TextStyle tileTitleText(BuildContext context) {
    return TextStyle(
      height: 1.1,
      color: Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
  }

  // ビデオタイルの動画ホスト名テキスト
  static TextStyle tileHostNameText(BuildContext context) {
    return TextStyle(
      fontSize: 10,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  // ビデオタイルの動画タグ名テキスト
  static TextStyle tileTagNameText(BuildContext context) {
    return TextStyle(
      fontSize: 11,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  static ButtonStyle defaultButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).colorScheme.secondaryContainer,
      ),
      foregroundColor: MaterialStateProperty.all(
        Theme.of(context).colorScheme.onBackground,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          // side: BorderSide(
          //   color: Theme.of(context).colorScheme.onBackground,
          // ),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  static ButtonStyle accentButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).colorScheme.tertiary,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
