import 'package:get/get.dart';
import 'package:watchme/config/theme/app_colors.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/services/movie_service.dart';

class HomeController extends GetxController {
  final MovieService _movieService = Get.find<MovieService>();

  final isLoading = true.obs;
  final trendingMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;
  final upcomingMovies = <MovieModel>[].obs;

  final currentBannerIndex = 0.obs;

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading(true);

      await Future.wait([
        _fetchTrendingMovies(),
        _fetchTopRatedMovies(),
        _fetchUpcomingMovies(),
      ]);

      await Future.wait([
        _fetchMissingDetails(trendingMovies),
        _fetchMissingDetails(topRatedMovies),
        _fetchMissingDetails(upcomingMovies),
      ]);
    } catch (e) {
      Get.snackbar(
        'Error Data Loading',
        'Gagal memuat data film. Cek koneksi internet Anda.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
      );
      print('Error fetching home data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> _fetchTrendingMovies() async {
    try {
      final result = await _movieService.fetchTrendingMovies();
      trendingMovies.assignAll(result.take(8).toList());
    } catch (e) {
      print('Error fetching trending movies: $e');
    }
  }

  Future<void> _fetchTopRatedMovies() async {
    try {
      final result = await _movieService.fetchTopRatedMovies();
      topRatedMovies.assignAll(result);
    } catch (e) {
      print('Error fetching top rated movies: $e');
    }
  }

  Future<void> _fetchUpcomingMovies() async {
    try {
      final result = await _movieService.fetchUpcomingMovies();
      upcomingMovies.assignAll(result);
    } catch (e) {
      print('Error fetching upcoming movies: $e');
    }
  }

  Future<void> _fetchMissingDetails(RxList<MovieModel> movies) async {
    if (movies.isEmpty) return;

    await Future.forEach(movies, (MovieModel movie) async {
      try {
        final detailedMovie = await _movieService.fetchMovieDetail(movie.id);
        final certification = await _movieService.fetchCertification(movie.id);

        final index = movies.indexOf(movie);
        if (index != -1) {
          movies[index] = movie.copyWith(
            genres: detailedMovie.genres,
            runtime: detailedMovie.runtime,
            certification: certification,
          );
          movies.refresh();
        }
      } catch (e) {
        print('Gagal mengambil detail untuk film ID ${movie.id}: $e');
      }
    });
  }
}
