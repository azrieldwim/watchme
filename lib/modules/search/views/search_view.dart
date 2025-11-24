import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/modules/search/controllers/search_controller.dart';
import '../../../shared/widgets/movie_result_card.dart';
import '../../../config/routes/app_routes.dart';

class SearchMovieView extends GetView<SearchMovieController> {
  const SearchMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search.', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: const Icon(Icons.tune), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: controller.searchInputController,
              onChanged: controller.onSearchTextChanged,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(
                  () =>
                      controller.searchQuery.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: controller.clearSearch,
                          )
                          : const SizedBox.shrink(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade900,
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.searchResults.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = controller.searchResults[index];
                    return MovieResultCard(
                      movie: movie,
                      onTap: () {
                        controller.addMovieToPreviousSearch(movie);
                        Get.toNamed(Routes.detail, arguments: movie.id);
                      },
                      onWatchlistTap: () {
                        controller.watchlistController.toggleWatchlist(movie);
                      },
                    );
                  },
                );
              }
              if (controller.previousResults.isNotEmpty) {
                return _buildPreviousResults(context);
              }
              return const Center(child: Text('Cari film berdasarkan judul.'));
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Previous Search',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: controller.clearPreviousResults,
                child: const Text('Clear All'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            itemCount: controller.previousResults.length,
            itemBuilder: (context, index) {
              final movie = controller.previousResults[index];
              return MovieResultCard(
                movie: movie,
                onTap: () {
                  controller.addMovieToPreviousSearch(movie);
                  Get.toNamed(Routes.detail, arguments: movie.id);
                },
                onWatchlistTap: () {
                  controller.watchlistController.toggleWatchlist(movie);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
