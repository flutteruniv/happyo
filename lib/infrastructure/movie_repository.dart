import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/movie/movie.dart';

final movieRepositoryProvider = Provider((ref) => MovieRepository()..init());

class MovieRepository {
  final _db = FirebaseFirestore.instance;
  late CollectionReference _movieRef;
  List<Movie> movieList = [];

  void init() {
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

  Map<String, dynamic> _jsonFromSnapshot<T extends DocumentSnapshot>(T json) {
    return {
      'youtubeId': json['youtubeId'],
      'hlsUrl': json['hlsUrl'],
      'likes': json['likes'],
      'views': json['views'],
      'hostName': json['hostName'],
      'hostId': json['hostId'],
      'downloadUrl': json['downloadUrl'],
      'videoHolder': json['videoHolder'],
      'category': json['category'],
      'postedAt': json['postedAt'],
      'title': json['title'],
      'tag': json['tag'],
    };
  }
}
