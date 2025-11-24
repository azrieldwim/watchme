import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/movie_model.dart';

class WatchlistService extends GetxService {
  final _box = GetStorage();
  final String _key = 'movie_watchlist';

  List<int> getWatchlistIds() {
    final List<dynamic> data = _box.read(_key) ?? [];
    return data.cast<int>();
  }

  bool isMovieInWatchlist(int movieId) {
    return getWatchlistIds().contains(movieId);
  }

  Future<void> toggleWatchlist(MovieModel movie) async {
    final List<int> ids = getWatchlistIds();
    final int movieId = movie.id;

    if (ids.contains(movieId)) {
      ids.remove(movieId);
      Get.snackbar(
        'Watchlist',
        '${movie.title} dihapus dari Watchlist.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      ids.add(movieId);
      Get.snackbar(
        'Watchlist',
        '${movie.title} ditambahkan ke Watchlist.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    await _box.write(_key, ids);
  }

  Future<void> clearWatchlist() async {
    await _box.remove(_key);
  }
}
