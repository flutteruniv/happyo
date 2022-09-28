import 'package:happyo/infrastructure/repository/movies_repository.dart';
import 'package:happyo/model/movie/movie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playListNotifierProvider =
    StateNotifierProvider<PlayListNotifier, List<Movie>?>((ref) {
  return PlayListNotifier(
    movieRepository: ref.read(movieRepositoryProvider),
  );
});

class PlayListNotifier extends StateNotifier<List<Movie>?> {
  PlayListNotifier({
    required MoviesRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const []);

  final MoviesRepository _movieRepository;

  Future<List<Movie>> fetchAll() async {
    return _movieRepository.fetchAll();
  }

  Future<void> addMovieToUsersMovieList(String listName, Movie movie) async {
    _movieRepository.addMovieToUsersMovieList(listName, movie);
  }

  Future<List<Movie>> fetchCategorizedPlayList(String categoryName) async {
    return _movieRepository.fetchCategorizedPlayList(categoryName);
  }

  Future<List<Movie>> fetchMyList() async {
    return _movieRepository.fetchMyList();
  }

  Future<void> removeMovieFromUsersMovieList(
      String listName, Movie movie) async {
    _movieRepository.removeMovieFromUsersMovieList(listName, movie);
  }

  // Future<List<Movie>> getUsersMovieList(String listName) async {
  //   return _movieRepository.getUsersMovieList(listName);
  // }
}
