import '../models/cast_model.dart';
import '../models/video_model.dart';
import 'api_service.dart';
import 'movie_api.dart';
import '../models/movie_model.dart';

class MovieService {
  final ApiService _api = ApiService();

  Future<List<MovieModel>> fetchMovies(String endpoint) async {
    final response = await _api.get(endpoint);
    return (response.data["results"] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  Future<MovieModel> fetchMovieDetail(int id) async {
    final response = await _api.get(MovieApi.detail(id));
    return MovieModel.fromJson(response.data);
  }

  Future<List<MovieModel>> fetchTrendingMovies() {
    return fetchMovies(MovieApi.popular);
  }

  Future<List<MovieModel>> fetchTopRatedMovies() {
    return fetchMovies(MovieApi.topRated);
  }

  Future<List<MovieModel>> fetchUpcomingMovies() {
    return fetchMovies(MovieApi.upcoming);
  }

  Future<String?> fetchCertification(int movieId) async {
    final response = await _api.get(MovieApi.releaseDates(movieId));
    final List results = response.data['results'] ?? [];
    final usRelease = results.firstWhere(
      (item) => item['iso_3166_1'] == 'US',
      orElse: () => null,
    );
    if (usRelease != null && usRelease['release_dates'] is List) {
      final releaseDatesList = usRelease['release_dates'] as List;
      for (var data in releaseDatesList) {
        if (data['certification'] != null && data['certification'].isNotEmpty) {
          return data['certification'] as String?;
        }
      }
    }
    return null;
  }

  Future<List<CastModel>> fetchCredits(int id) async {
    final response = await _api.get(MovieApi.credits(id));
    return (response.data["cast"] as List)
        .map((e) => CastModel.fromJson(e))
        .toList();
  }

  Future<List<CrewModel>> fetchCrew(int id) async {
    final response = await _api.get(MovieApi.credits(id));
    return (response.data["crew"] as List)
        .map((e) => CrewModel.fromJson(e))
        .toList();
  }

  Future<List<VideoModel>> fetchVideos(int id) async {
    final response = await _api.get(MovieApi.videos(id));
    return (response.data["results"] as List)
        .map((e) => VideoModel.fromJson(e))
        .toList();
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    final endpoint = MovieApi.search;
    final response = await _api.get(endpoint, params: {'query': query});
    return (response.data["results"] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }
}
