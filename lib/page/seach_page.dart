import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';
import 'package:nil/nil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

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
        // The search area here
        title: SizedBox(
          height: 32,
          child: SizedBox(
            width: 300,
            child: TextField(
              controller: _controller,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: '検索キーワードを入力',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              onEditingComplete: () async {
                if (_controller.text.isNotEmpty) {
                  final date =
                      DateTime.now().toLocal().toIso8601String(); // 現在の日時
                  final uid = FirebaseAuth
                      .instance.currentUser!.uid; // AddPostPage のデータを参照
                  await FirebaseFirestore.instance
                      .collection('history') // コレクションID指定
                      .doc() // ドキュメントID自動生成
                      .set(
                          {'text': _controller.text, 'uid': uid, 'date': date});
                  _controller.clear();
                  setState(() {
                    ishistoryVisible = _controller.text.isEmpty;
                  });
                  print(_controller.text);
                }
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onBackground)),
              onPressed: () {
                Routes.pushNamed(
                  context,
                  Routes.searchResult,
                  args: _controller.text,
                );
              },
              child: const Text('検索'),
            ),
          ),
        ],
      ),
      body: ishistoryVisible
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
                  // 投稿メッセージ一覧を取得（非同期処理）
                  // 投稿日時でソート
                  future: FirebaseFirestore.instance
                      .collection('history')
                      .orderBy('date', descending: true)
                      .limit(6)
                      .get(),
                  builder: (context, snapshot) {
                    // データが取得できた場合
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      // 取得した投稿メッセージ一覧を元にリスト表示
                      return ListView(
                        shrinkWrap: true,
                        itemExtent: 34,
                        children: documents.map((document) {
                          return InkWell(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('history')
                                  .doc(document.id)
                                  .get()
                                  .then((DocumentSnapshot snapshot) {
                                _controller.text = snapshot.get('text');
                                print(_controller.text.toString());
                              });
                              setState(() {});
                            },
                            child: ListTile(
                              title: Text(document['text']),
                              // 自分の投稿メッセージの場合は削除ボタンを表示
                              trailing: document['uid'] ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () async {
                                        // 投稿メッセージのドキュメントを削除
                                        await FirebaseFirestore.instance
                                            .collection('history')
                                            .doc(document.id)
                                            .delete();
                                        setState(() {});
                                      },
                                    )
                                  : nil,
                              leading: const Icon(Icons.search),
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
}
