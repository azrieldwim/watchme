import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watchme/modules/watchlist/controllers/watchlist_controller.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/models/cast_model.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/movie_service.dart';

class DetailController extends GetxController {
  final MovieService _movieService = Get.find<MovieService>();
  final WatchlistController watchlistController =
      Get.find<WatchlistController>();
  final movieId = Get.arguments as int;

  final isLoading = true.obs;
  final movie = Rx<MovieModel?>(null);
  final castList = <CastModel>[].obs;
  final crewList = <CrewModel>[].obs;
  final trailerKey = ''.obs;
  final activeTab = 'Cast'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovieData(movieId);
  }

  void changeTab(String tabName) {
    activeTab.value = tabName;
  }

  Future<void> fetchMovieData(int id) async {
    try {
      isLoading(true);

      final results = await Future.wait([
        _movieService.fetchMovieDetail(id),
        _movieService.fetchCredits(id),
        _movieService.fetchCrew(id),
        _movieService.fetchVideos(id),
      ]);

      movie.value = results[0] as MovieModel;

      castList.assignAll(results[1] as List<CastModel>);
      crewList.assignAll(results[2] as List<CrewModel>);

      final videos = results[3] as List<VideoModel>;
      final trailer = videos.firstWhereOrNull(
        (v) => v.type == 'Trailer' && v.site == 'YouTube',
      );
      if (trailer != null) {
        trailerKey.value = trailer.key;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat detail film: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error fetching movie detail: $e');
    } finally {
      isLoading(false);
      update();
    }
  }

  void launchTrailer() async {
    if (trailerKey.isNotEmpty) {
      final url = Uri.parse(
        'https://www.youtube.com/watch?v=${trailerKey.value}',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        Get.snackbar(
          'Error',
          'Tidak dapat membuka trailer.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  String get writer =>
      crewList.firstWhereOrNull((c) => c.job == 'Writer')?.name ?? 'N/A';

  String get director =>
      crewList.firstWhereOrNull((c) => c.job == 'Director')?.name ?? 'N/A';
}
