import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/my_theme.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    logger.error("application initialize error: ", args: e);
  }
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyTheme.appThemeDataLight,
      darkTheme: MyTheme.appThemeDataDark,
      initialRoute: Routes.index,
      routes: Routes.routes,
    );
  }
}
