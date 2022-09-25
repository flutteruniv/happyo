import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/common/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';

class SearchPage extends StatefulHookConsumerWidget {
  const SearchPage({super.key});

  @override
  ConsumerState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState {
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  //検索バーに入力されていなければtrue → 検索履歴を表示する
  bool ishistoryVisible = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        ishistoryVisible = _controller.text.isEmpty;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 検索ワード入力エリア
        title: SizedBox(
          height: 36,
          child: TextField(
            controller: _controller,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              prefixIcon: const Icon(Icons.search),
              hintText: 'キーワードを入力',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
            ),
          ),
        ),
        actions: [
          // 検索ボタン
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 12, left: 12),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.tertiary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              onPressed: () async {
                _search();
              },
              child: const Text(
                '検索',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      // 検索履歴
      body: ishistoryVisible && user != null
          ? Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 16),
                    child: Text("検索履歴"),
                  ),
                ),
                FutureBuilder<QuerySnapshot>(
                  future: _getSearchKeywordHistory(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
                  ) {
                    // データが取得できた場合
                    if (snapshot.hasData) {
                      final documents = snapshot.data!.docs;
                      // 取得した投稿メッセージ一覧を元にリスト表示
                      return ListView(
                        shrinkWrap: true,
                        itemExtent: 34,
                        children: documents.map((document) {
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                _setKeyword(document.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(document['text']),
                              ),
                            ),
                            // 自分の投稿メッセージの場合は削除ボタンを表示
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () async {
                                _removeHistory(document.id);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    }
                    // データが読込中の場合
                    return const Center(
                      child: Text('読込中...'),
                    );
                  },
                ),
              ],
            )
          : nil,
    );
  }

  Future<void> _search() async {
    if (user != null) {
      final date = DateTime.now().toLocal().toIso8601String(); // 現在の日時
      final uid = FirebaseAuth.instance.currentUser!.uid; // AddPostPage のデータを参照
      await FirebaseFirestore.instance
          .collection('history') // コレクションID指定
          .doc() // ドキュメントID自動生成
          .set({'text': _controller.text, 'uid': uid, 'date': date});
      setState(() {
        ishistoryVisible = _controller.text.isEmpty;
      });
      logger.debug(_controller.text);
      Routes.pushNamed(context, Routes.searchResult, args: _controller.text);
      _controller.clear();
    }
  }

  Future<void> _setKeyword(String id) async {
    await FirebaseFirestore.instance
        .collection('history')
        .doc(id)
        .get()
        .then((DocumentSnapshot snapshot) {
      _controller.text = snapshot.get('text');
      logger.debug(_controller.text.toString());
    });
    setState(() {});
  }

  Future<void> _removeHistory(String id) async {
    // 投稿メッセージのドキュメントを削除
    await FirebaseFirestore.instance.collection('history').doc(id).delete();
    setState(() {});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getSearchKeywordHistory() async {
    // 投稿メッセージ一覧を取得（非同期処理）
    // 投稿日時でソート
    final snapshot = await FirebaseFirestore.instance
        .collection('history')
        .where("uid", isEqualTo: user!.uid)
        .orderBy('date', descending: true)
        .limit(6)
        .get();
    return snapshot;
  }
}
