import 'package:cloud_firestore/cloud_firestore.dart';

// firestoreのドキュメントを扱うクラスを作る。
class testClass {
  // ドキュメントを扱うDocumentSnapshotを引数にしたコンストラクタを作る
  testClass(DocumentSnapshot doc) {
    //　ドキュメントの持っているフィールドを代入
    test_field = doc['test_field'];
    created_at = doc['created_at'];
  }
  // testで扱うフィールドを定義しておく。
  // null回避でlateを宣言
  late String test_field;
  late Timestamp created_at;
}