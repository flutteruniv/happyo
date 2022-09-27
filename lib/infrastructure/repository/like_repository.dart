import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());

class LikeRepository {
  final _likesRef = FirebaseFirestore.instance.collection('likes');
  late String _userId;
  LikeRepository() {
    _userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<bool> isLike(String id) async {
    final snapshot = await _findLikeById(id);
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.get('isLike') as bool;
    }
    return false;
  }

  Future<void> like(String id) async {
    final record = {'userId': _userId, 'movieId': id, 'isLike': true};
    final snapshot = await _findLikeById(id);
    if (snapshot.docs.isEmpty) {
      _likesRef.doc().set(record);
    } else {
      return snapshot.docs.first.reference.set(record);
    }
  }

  Future<void> unLike(String id) async {
    final record = {'userId': _userId, 'movieId': id, 'isLike': false};
    final snapshot = await _findLikeById(id);
    if (snapshot.docs.isEmpty) {
      _likesRef.doc().set(record);
    } else {
      return snapshot.docs.first.reference.set(record);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _findLikeById(String id) async {
    return _likesRef
        .where('userId', isEqualTo: _userId)
        .where('movieId', isEqualTo: id)
        .get();
  }
}
