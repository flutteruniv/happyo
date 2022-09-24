import 'package:cloud_firestore/cloud_firestore.dart';
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
