import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/firebase_options.dart';

Future<void> main() async {
  // Unhandled Exception: [core/duplicate-app] A Firebase App named "[DEFAULT]" already exists
  try{
    WidgetsFlutterBinding.ensureInitialized();
    // await dotenv.load(fileName: '.env');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch(e){}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: Routes.index,
      routes: Routes.routes,
    );
  }
}
