import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:watchme/config/routes/app_routes.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/data/services/api_config.dart';
import 'package:watchme/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:watchme/shared/widgets/movie_info_chip.dart';
import 'package:watchme/utils/app_utils.dart';
import '../../../data/models/movie_model.dart';
import '../controllers/home_controller.dart';
import 'dart:ui';

class MainBanner extends GetView<HomeController> {
  final RxList<MovieModel> movies;

  const MainBanner({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (movies.isEmpty) {
        return const SizedBox.shrink();
      }
      return CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          final MovieModel movie = movies[index];
          return _buildBannerContent(context, movie);
        },
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          height: 260,
          onPageChanged: (index, reason) {
            controller.updateBannerIndex(index);
          },
        ),
      );
    });
  }

  Widget _buildBannerContent(BuildContext context, MovieModel movie) {
    final WatchlistController watchlistController =
        Get.find<WatchlistController>();
    final String backdropPath = movie.backdropPath;
    final String imageSource = getImageUrl(
      backdropPath,
      baseUrl: ApiConfig.imageBaseUrl,
    );
    final bool isNetworkImage = imageSource.startsWith(
      'assets/images/placeholder.png',
    );
    final String releaseYear = movie.releaseDate.split('-').first;
    final String genreNames = (movie.genres ?? []).take(4).join(' ');
    final String formattedRuntime = formatRuntime(movie.runtime);
    final String certification = movie.certification ?? 'NA';

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.detail, arguments: movie.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        padding: EdgeInsets.all(16),
        height: 260,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  isNetworkImage
                      ? Image.asset(
                        imageSource,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      )
                      : FadeInImage.assetNetwork(
                        placeholder: localPlaceholderPath,
                        image: imageSource,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    height: 92,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColors.textSecondary,
                          width: 0.5,
                        ),
                      ),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          genreNames.isEmpty ? 'Loading Genres...' : genreNames,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            MovieInfoChip(label: certification),
                            const SizedBox(width: 8),
                            MovieInfoChip(label: releaseYear),
                            const SizedBox(width: 8),
                            MovieInfoChip(label: formattedRuntime),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final bool isCurrentWatched = watchlistController
                              .watchlistMovieIds
                              .contains(movie.id);
                          return ElevatedButton(
                            onPressed: () {
                              watchlistController.toggleWatchlist(movie);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isCurrentWatched
                                      ? AppColors.red
                                      : AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              minimumSize: Size.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              isCurrentWatched
                                  ? 'In Watchlist'
                                  : 'Add To Watchlist',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.white),
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        _buildDotsIndicator(context, movies.length),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotsIndicator(BuildContext context, int totalSlides) {
    const int visibleDots = 4;

    return Obx(
      () => Row(
        children: List.generate(visibleDots, (index) {
          final int activeIndex = controller.currentBannerIndex.value;
          final int activeDotIndex = activeIndex % visibleDots;
          final bool isActive = activeDotIndex == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isActive ? 24.0 : 6.0,
            height: 6.0,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: AppColors.white.withOpacity(isActive ? 1.0 : 0.4),
            ),
          );
        }),
      ),
    );
  }
}