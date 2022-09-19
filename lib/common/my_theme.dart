import 'package:flutter/material.dart';

const Color blandColorDark = Colors.black;
const Color blandColorLight = Colors.white;
const Color blandColorAccent = Color.fromARGB(255, 255, 91, 21);
const Color unimplementedColor = Color.fromARGB(255, 255, 0, 0);

abstract class MyTheme {
  static ThemeData? get appThemeDataLight {
    return ThemeData.from(
      colorScheme: ColorScheme(
        // プロパティの内容は下記URLを参照
        // https://api.flutter.dev/flutter/material/ColorScheme-class.html
        background: blandColorLight, // スクロール可能なコンテンツの背後に表示される色
        brightness: Brightness.light,
        error: unimplementedColor, // 入力検証エラー
        errorContainer: unimplementedColor, // errorより強調する必要のないerror要素に使用される色
        inversePrimary:
            unimplementedColor, // SnackBarでアラートに注意を向けさせるなど、周囲のUIに表示されるものの反転を表示するために使用される表面の色
        onBackground: blandColorDark, // backgroundに対してはっきりと判読できる色
        onError: unimplementedColor, // errorに対してはっきりと判読できる色
        onInverseSurface: unimplementedColor, // inverseSurfaceに対してはっきりと判読できる色
        onPrimary: unimplementedColor, // primaryに対してはっきりと判読できる色
        onSecondary: unimplementedColor, // secondaryに対してはっきりと判読できる色
        onSecondaryContainer:
            blandColorDark, // secondaryContainerに対してはっきりと判読できる色
        onSurface: blandColorDark, // surfaceに対してはっきりと判読できる色
        onTertiary: unimplementedColor, // tertiaryに対してはっきりと判読できる色
        onTertiaryContainer:
            unimplementedColor, // tertiaryContainerに対してはっきりと判読できる色
        outline: unimplementedColor, // 使いやすさを向上させる境界と強調を作成する色
        primary: blandColorLight, // アプリの画面とコンポーネントで最も頻繁に表示される色
        primaryContainer: unimplementedColor, // primaryより強調する必要のない要素に使用される色
        secondary: blandColorDark, // 目立たない部分に使用するアクセントカラー
        secondaryContainer:
            blandColorDark.withAlpha(60), // secondaryより強調する必要のない要素に使用される色
        shadow: unimplementedColor, // ドロップシャドウなどに使用される色
        surface: blandColorLight, // カードなどのウィジェットの背景色
        surfaceTint: blandColorAccent,
        // surfaceを使用したコンポーネントに対する差別化に使用できる色
        tertiary: blandColorAccent, // 入力フィールドなどの要素に注目を集めたりする対照的なアクセントとして使用される色
        tertiaryContainer: unimplementedColor, // tertiaryより強調する必要のない要素に使用される色
      ),
      textTheme: MyTheme.appTextScheme,
      useMaterial3: true,
    );
  }

  static ThemeData? get appThemeDataDark {
    return ThemeData.from(
      colorScheme: ColorScheme(
        // プロパティの内容は下記URLを参照
        // https://api.flutter.dev/flutter/material/ColorScheme-class.html
        background: blandColorDark, // スクロール可能なコンテンツの背後に表示される色
        brightness: Brightness.dark,
        error: unimplementedColor, // 入力検証エラー
        errorContainer: unimplementedColor, // errorより強調する必要のないerror要素に使用される色
        inversePrimary:
            unimplementedColor, // SnackBarでアラートに注意を向けさせるなど、周囲のUIに表示されるものの反転を表示するために使用される表面の色
        onBackground: blandColorLight, // backgroundに対してはっきりと判読できる色
        onError: unimplementedColor, // errorに対してはっきりと判読できる色
        onInverseSurface: unimplementedColor, // inverseSurfaceに対してはっきりと判読できる色
        onPrimary: unimplementedColor, // primaryに対してはっきりと判読できる色
        onSecondary: unimplementedColor, // secondaryに対してはっきりと判読できる色
        onSecondaryContainer:
            blandColorLight, // secondaryContainerに対してはっきりと判読できる色
        onSurface: blandColorLight, // surfaceに対してはっきりと判読できる色
        onTertiary: unimplementedColor, // tertiaryに対してはっきりと判読できる色
        onTertiaryContainer:
            unimplementedColor, // tertiaryContainerに対してはっきりと判読できる色
        outline: unimplementedColor, // 使いやすさを向上させる境界と強調を作成する色
        primary: blandColorLight, // アプリの画面とコンポーネントで最も頻繁に表示される色
        primaryContainer: unimplementedColor, // primaryより強調する必要のない要素に使用される色
        secondary: blandColorLight, // 目立たない部分に使用するアクセントカラー
        secondaryContainer:
            blandColorLight.withAlpha(60), // secondaryより強調する必要のない要素に使用される色
        shadow: unimplementedColor, // ドロップシャドウなどに使用される色
        surface: blandColorDark, // カードなどのウィジェットの背景色
        surfaceTint: blandColorAccent,
        // surfaceを使用したコンポーネントに対する差別化に使用できる色
        tertiary: blandColorAccent, // 入力フィールドなどの要素に注目を集めたりする対照的なアクセントとして使用される色
        tertiaryContainer: unimplementedColor, // tertiaryより強調する必要のない要素に使用される色
      ),
      textTheme: MyTheme.appTextScheme,
      useMaterial3: true,
    );
  }

  static TextTheme? get appTextScheme {
    return null;
    return TextTheme(
      // bodyLarge: TextStyle(color: Colors.black),
      // bodyMedium: TextStyle(color: Colors.black),
      // bodySmall: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      button: TextStyle(color: blandColorAccent),
    );
  }
}
