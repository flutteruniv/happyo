import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/movie/movie.dart';
import 'movie_repository.dart';

final playListNotifierProvider =
    StateNotifierProvider<PlayListNotifier, List<Movie>?>((ref) {
  return PlayListNotifier(
    movieRepository: ref.read(movieRepositoryProvider),
  );
});

class PlayListNotifier extends StateNotifier<List<Movie>?> {
  PlayListNotifier({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const []);

  final MovieRepository _movieRepository;

  Future<void> fetchAll() async {
    state = await _movieRepository.fetchAll();
  }
}
