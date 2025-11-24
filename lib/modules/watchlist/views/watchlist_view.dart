import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/watchlist_controller.dart';
import '../../../shared/widgets/movie_result_card.dart';
import '../../../config/routes/app_routes.dart';

class WatchlistView extends GetView<WatchlistController> {
  const WatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Watchlist', style: Theme.of(context).textTheme.titleLarge),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: controller.clearAllMovies,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) => controller.searchLocalQuery.value = query,
              decoration: InputDecoration(
                hintText: 'Cari film di Watchlist...',
                prefixIcon: const Icon(Icons.search),
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
              final list = controller.filteredMovies;

              if (controller.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.watchlistMovies.isEmpty) {
                return const Center(child: Text('Watchlist Anda kosong.'));
              }

              if (list.isEmpty) {
                return Center(
                  child: Text('Tidak ada hasil untuk pencarian ini.'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final movie = list[index];
                  return MovieResultCard(
                    movie: movie,
                    onTap: () {
                      Get.toNamed(Routes.detail, arguments: movie.id);
                    },
                    onWatchlistTap: () {controller.toggleWatchlist(movie);},
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
