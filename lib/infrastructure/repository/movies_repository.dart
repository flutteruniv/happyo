import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happyo/algolia_options.dart';
import 'package:happyo/infrastructure/repository/like_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/movie/movie.dart';

final movieRepositoryProvider = Provider((ref) => MoviesRepository(
      likeRepository: ref.read(likeRepositoryProvider),
    ));

class MoviesRepository {
  final _db = FirebaseFirestore.instance;
  late CollectionReference _movieRef;
  LikeRepository likeRepository;

  MoviesRepository({
    required this.likeRepository,
  }) {
    _movieRef = _db.collection('movies');
  }

  Future<List<Movie>> fetchAll() async {
    final snapshot = await _movieRef.get();
    return snapshot.docs
        .map(
          (item) => Movie.fromJson(
            _jsonFromSnapshot(item),
          ),
        )
        .toList();
  }

  Future<List<Movie>> search(String keyword) async {
    List<Movie> list = [];
    Algolia algolia = AlgoliaOptions.instance;
    AlgoliaQuery query = algolia.index('movies-dev').query(keyword);
    query = query.setLength(100);
    AlgoliaQuerySnapshot snapshot = await query.getObjects();
    if (snapshot.hasHits) {
      for (final hit in snapshot.hits) {
        list.add(Movie.fromJson(hit.data));
      }
    }
    return list;
  }

  Future<void> like(Movie movie) async {
    return _movieRef.doc(movie.id).update({"likes": FieldValue.increment(1)});
  }

  Future<void> unLike(Movie movie) async {
    return _movieRef.doc(movie.id).update({"likes": FieldValue.increment(-1)});
  }

  Future<void> play(Movie movie) async {
    return _movieRef.doc(movie.id).update({"views": FieldValue.increment(1)});
  }

  Future<bool> addMovieToUsersMovieList(String listName, Movie movie) async {
    // DocumentReference<Map<String, dynamic>> docRef;
    final docRef = _db.collection('usersMovieList');
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await docRef
        .where('userId', isEqualTo: userId)
        .where('listName', isEqualTo: listName)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final listRef = snapshot.docs.first.reference.collection('listMovies');
      final movieSnapshot =
          await listRef.where('id', isEqualTo: movie.id).get();
      // 未登録の場合のみ登録する
      if (movieSnapshot.docs.isEmpty) {
        snapshot.docs.first.reference
            .collection('listMovies')
            .doc(movie.id)
            .set(movie.toJson());
        return true;
      }
    } else {
      // userId,listNameが登録されていないとき
      // userId,listNameの登録
      docRef.doc(userId).set({
        'userId': userId,
        'listName': listName,
      });
      // myListに追加した動画の情報登録
      docRef
          .doc(userId)
          .collection('listMovies')
          .doc(movie.id)
          .set(movie.toJson());
    }
    return false;
  }

  Future<void> removeMovieFromUsersMovieList(
      String listName, Movie movie) async {
    final snapshot = await _db
        .collection('usersMovieList')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('listName', isEqualTo: listName)
        .get();
    if (snapshot.docs.isNotEmpty) {
      print(movie.id);
      snapshot.docs.first.reference
          .collection('listMovies')
          .doc(movie.id)
          .delete();
    }
  }

  Future<List<Movie>> fetchCategorizedPlayList(String categoryName) async {
    List<Movie> list = [];
    final snapshot = await _db
        .collection('movies')
        .where('categoryList', arrayContains: categoryName)
        .get();
    for (final doc in snapshot.docs) {
      list.add(Movie.fromJson(doc.data()));
    }
    print(list);
    return list;
  }

  Future<List<Movie>> fetchMyList() async {
    List<Movie> list = [];
    final snapshot = await _db
        .collection('usersMovieList')
        .where('listName', isEqualTo: 'MyList')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final movieSnapshot =
          await snapshot.docs.first.reference.collection('listMovies').get();
      for (final doc in movieSnapshot.docs) {
        list.add(Movie.fromJson(doc.data()));
      }
    }
    print(list);
    return list;
  }

  // Future<List<Movie>> getUsersMovieList(String listName) async {
  //   List<Movie> list = [];
  //   final listSnapshot = await _db.collection('usersMovieList').where({
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //     'listName': listName,
  //   }).get();
  //   for (final listDoc in listSnapshot.docs) {
  //     final moviesSnapshot =
  //         await listDoc.reference.collection('listMovies').get();
  //     for (final movieDoc in moviesSnapshot.docs) {
  //       list.add(Movie.fromJson(movieDoc.data()));
  //     }
  //   }
  //   return list;
  // }

  Map<String, dynamic> _jsonFromSnapshot<T extends DocumentSnapshot>(T json) {
    return {
      'id': json['id'],
      'title': json['title'],
      'categoryList': json['categoryList'],
      'thumbnailImage': json['thumbnailImage'],
      'downloadUrl': json['downloadUrl'],
      'streamingUrl': json['streamingUrl'],
      'platform': json['platform'],
      'hostId': json['hostId'],
      'hostName': json['hostName'],
      'tagList': json['tagList'],
      'likes': json['likes'],
      'views': json['views'],
      'createdAt': json['createdAt'],
      'createdBy': json['createdBy'],
      'updatedAt': json['updatedAt'],
      'updatedBy': json['updatedBy'],
      'deletedAt': json['deletedAt'],
      'deletedBy': json['deletedBy'],
    };
  }
}
