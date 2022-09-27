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

  Future<void> fetchAll() async {
    state = await _movieRepository.fetchAll();
  }

  Future<void> addMovieToUsersMovieList(String listName, Movie movie) async {
    _movieRepository.addMovieToUsersMovieList(listName, movie);
  }

  // Future<List<Movie>> getUsersMovieList(String listName) async {
  //   return _movieRepository.getUsersMovieList(listName);
  // }
}
