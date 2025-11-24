import 'package:get/get.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/services/watchlist_service.dart';
import '../../../data/services/movie_service.dart';

class WatchlistController extends GetxController {
  final WatchlistService _watchlistService = Get.find<WatchlistService>();
  final MovieService _movieService = Get.find<MovieService>();

  final watchlistMovieIds = <int>[].obs;
  final watchlistMovies = <MovieModel>[].obs;
  final isLoading = true.obs;
  final searchLocalQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    watchlistMovieIds.assignAll(_watchlistService.getWatchlistIds());
    fetchWatchlistDetails();
    ever(watchlistMovieIds, (_) => fetchWatchlistDetails());
  }

  List<MovieModel> get filteredMovies {
    if (searchLocalQuery.isEmpty) {
      return watchlistMovies;
    }
    final query = searchLocalQuery.value.toLowerCase();
    return watchlistMovies.where((movie) {
      return movie.title.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> fetchWatchlistDetails() async {
    if (watchlistMovieIds.isEmpty) {
      watchlistMovies.clear();
      isLoading(false);
      return;
    }

    isLoading(true);
    try {
      final futures =
          watchlistMovieIds
              .map((id) => _movieService.fetchMovieDetail(id))
              .toList();
      final List<MovieModel> movies = await Future.wait(futures);

      watchlistMovies.assignAll(
        movies.where((m) => m.title.isNotEmpty).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat detail Watchlist: $e');
    } finally {
      isLoading(false);
    }
  }

  void clearAllMovies() {
    _watchlistService.clearWatchlist().then((_) {
      watchlistMovieIds.clear();
      Get.snackbar(
        'Watchlist',
        'Semua film telah dihapus.',
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  void toggleWatchlist(MovieModel movie) {
    _watchlistService.toggleWatchlist(movie).then((_) {
      watchlistMovieIds.assignAll(_watchlistService.getWatchlistIds());
    });
  }

  bool isMovieInWatchlist(int movieId) {
    return _watchlistService.isMovieInWatchlist(movieId);
  }
}
