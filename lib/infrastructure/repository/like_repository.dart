import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());

class LikeRepository {
  final _db = FirebaseFirestore.instance.collection('likes');

  Future<bool> isLike(String id) async {
    final snapshot = await _db.doc(id).get();
    if (snapshot.exists) {
      return snapshot.get('isLike') as bool;
    }
    return false;
  }

  Future<void> like(String id) async {
    return _db.doc(id).set({'isLike': true});
  }

  Future<void> unLike(String id) async {
    return _db.doc(id).set({'isLike': false});
  }
}
