import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happyo/infrastructure/repository/like_repository.dart';
import 'package:happyo/infrastructure/repository/movies_repository.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:happyo/model/movie/movie_platform.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final movieStateNotifierProvider =
    StateNotifierProvider<MovieNotifier, Movie?>((ref) {
  return MovieNotifier(
    movieRepository: ref.read(movieRepositoryProvider),
    // movieListRepository: ref.read(movieListRepositoryProvider),
    likeRepository: ref.read(likeRepositoryProvider),
  );
});

class MovieNotifier extends StateNotifier<Movie?> {
  final MovieRepository _movieRepository;
  // final MovieListRepository _movieListRepository;
  final LikeRepository _likeRepository;

  MovieNotifier({
    required MovieRepository movieRepository,
    // required MovieListRepository movieListRepository,
    required LikeRepository likeRepository,
  })  : _movieRepository = movieRepository,
        _likeRepository = likeRepository,
        super(null);

  Future<Movie?> findById(String id) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('movies').doc(id).get();
    return Movie.fromJson(snapshot.data()!);
  }

  void set(Movie? movie) async {
    state = movie;
  }

  Future<bool> isLike() async {
    return _likeRepository.isLike(state!.id!);
  }

  Future<void> like() async {
    if (state != null) {
      if (!await _likeRepository.isLike(state!.id!)) {
        _movieRepository.like(state!);
        _likeRepository.like(state!.id!);
      }
    }
    state = await findById(state!.id!);
  }

  Future<void> unLike() async {
    if (state != null) {
      if (await _likeRepository.isLike(state!.id!)) {
        _movieRepository.unLike(state!);
        _likeRepository.unLike(state!.id!);
      }
    }
    state = await findById(state!.id!);
  }

  Future<void> addToMyList() async {
    if (state != null) {
      // _movieListRepository.add(state!);
    }
  }

  Future<void> removeFromMyList() async {
    if (state != null) {
      // _movieListRepository.remove(state!);
    }
  }

  Future<void> share() async {
    if (state != null) {
      // TODO: uninplemented
      // _analyticsRepository.shareMovie();
    }
  }

  Future<void> download() async {
    if (state != null) {
      if (state!.platform == MoviePlatform.happyo) {
        // TODO: uninplemented
        // _movieRepository.download(state!);
      }
    }
  }
}
