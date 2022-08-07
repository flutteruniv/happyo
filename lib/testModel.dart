import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:happyo/testClass.dart';

class testModel extends ChangeNotifier {
  // ListView.builderで使うためのtestのList testsを用意しておく。　
  List<testClass> tests = [];

  Future<void> fetchBooks() async {
    // Firestoreからコレクション'test_document'(QuerySnapshot)を取得してdocsに代入。
    final docs = await FirebaseFirestore.instance.collection('test').get();

    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // map(): Listの各要素をtestClassに変換
    // toList(): Map()から返ってきたIterable→Listに変換する。
    final tests = docs.docs
        .map((doc) => testClass(doc))
        .toList();
    this.tests = tests;
    notifyListeners();
  }
}