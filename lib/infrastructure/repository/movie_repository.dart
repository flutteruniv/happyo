import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happyo/algolia_options.dart';
import 'package:happyo/infrastructure/repository/like_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/movie/movie.dart';

final movieRepositoryProvider = Provider((ref) => MovieRepository(
      likeRepository: ref.read(likeRepositoryProvider),
    ));

class MovieRepository {
  final _db = FirebaseFirestore.instance;
  late CollectionReference _movieRef;
  List<Movie> movieList = [];
  LikeRepository likeRepository;

  MovieRepository({
    required this.likeRepository,
  }) {
    _movieRef = _db.collection('movie');
  }

  Future<List<Movie>> fetchAll() async {
    final snapshot = await _movieRef.get();
    movieList = snapshot.docs
        .map(
          (item) => Movie.fromJson(
            _jsonFromSnapshot(item),
          ),
        )
        .toList();

    return movieList;
  }

  Future<List<Movie>> search(String keyword) async {
    List<Movie> list = [];
    Algolia algolia = AlgoliaOptions.instance;
    AlgoliaQuery query = algolia.index('movie').query(keyword);
    query = query.setLength(100);
    AlgoliaQuerySnapshot snapshot = await query.getObjects();
    if (snapshot.hasHits) {
      for (final hit in snapshot.hits) {
        list.add(Movie.fromJson(hit.data));
      }
    }

    print(list);
    return list;
  }

  Future<void> like(Movie movie) async {
    return _movieRef.doc(movie.id).update({"likes": FieldValue.increment(1)});
  }

  Future<void> unLike(Movie movie) async {
    return _movieRef.doc(movie.id).update({"likes": FieldValue.increment(-1)});
  }

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
