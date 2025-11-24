import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/services/movie_service.dart';

class SearchMovieController extends GetxController {
  final MovieService _movieService = Get.find<MovieService>();

  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final searchResults = <MovieModel>[].obs;
  final previousResults = <MovieModel>[].obs;
  final searchInputController = TextEditingController();
  Timer? _debounceTimer;

  void onSearchTextChanged(String query) {
    searchQuery.value = query;

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    if (query.isNotEmpty) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        searchMovies(query);
      });
    } else {
      searchResults.clear();
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading(true);
    searchResults.clear();

    try {
      final results = await _movieService.searchMovies(query);
      searchResults.assignAll(results);
      await _fetchMissingDetails(searchResults);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mencari film: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void addMovieToPreviousSearch(MovieModel movie) {
    previousResults.removeWhere((m) => m.id == movie.id);
    previousResults.insert(0, movie);
    if (previousResults.length > 10) {
      previousResults.removeLast();
    }
  }

  void clearSearch() {
    searchQuery('');
    searchResults.clear();
    searchInputController.clear();
  }

  void clearPreviousResults() {
    previousResults.clear();
  }

  Future<void> _fetchMissingDetails(RxList<MovieModel> movies) async {
    if (movies.isEmpty) return;
    await Future.wait(
      movies.map((movie) async {
        try {
          final detailedMovie = await _movieService.fetchMovieDetail(movie.id);
          final certification = await _movieService.fetchCertification(
            movie.id,
          );
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
      }),
    );
  }
}
