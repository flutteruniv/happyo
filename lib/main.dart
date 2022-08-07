import 'package:flutter/material.dart';
import 'package:happyo/testModel.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_tab_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<testModel>(
        // createでfetchBooks()も呼び出すようにしておく。
        create: (_) => testModel()..fetchBooks(),
        child: const testUI(),
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
        tab: [
          Tab(text: 'ネットワーク'),
          Tab(text: 'おすすめ'),
          Tab(text: 'セキュリティ'),
          Tab(text: 'AI'),
          Tab(text: 'AI2'),
        ],
        list: [
          Center(
            child: Text('ネットワーク', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('おすすめ', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('セキュリティ', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('AI', style: TextStyle(fontSize: 32.0)),
          ),
          Center(
            child: Text('AI2', style: TextStyle(fontSize: 32.0)),
          ),
        ],
      ),
    );
  }
}

class testUI extends StatelessWidget {
  const testUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('一覧'),
      ),
      body: Consumer<testModel>(
          builder: (context, model, child) {
            // FirestoreのドキュメントのList testsを取り出す。
            final tests = model.tests;
            return ListView.builder(
              // Listの長さを先ほど取り出したtestsの長さにする。
              itemCount: tests.length,
              // indexにはListのindexが入る。
              itemBuilder: (context, index) {
                return ListTile(
                  //　books[index]でList booksのindex番目の要素が取り出せる。
                  title: Text(tests[index].test_field),
                  subtitle: Text(tests[index].created_at.toDate().toString()),
                );
              },
            );
          },
      )
    );
  }
}
