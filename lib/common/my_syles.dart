import 'package:flutter/material.dart';

abstract class MyStyles {
  static TextStyle defaultText(BuildContext context) {
    return TextStyle(
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
