import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/data/models/movie_model.dart';
import 'package:watchme/data/services/api_config.dart';
import 'package:watchme/shared/widgets/movie_info_chip.dart';
import 'package:watchme/utils/app_utils.dart';
import '../controllers/detail_controller.dart';

class DetailMovieSection extends GetView<DetailController> {
  final MovieModel movie;

  const DetailMovieSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String backdropUrl = '${ApiConfig.imageBaseUrl}${movie.backdropPath}';
    final String formattedRuntime = formatRuntime(movie.runtime);
    final String releaseYear = movie.releaseDate.split('-').first;
    final String certification = movie.certification ?? 'N/A';
    final String genres = (movie.genres ?? ['N/A']).take(4).join(' • ');

    return Column(
      children: [
        SizedBox(height: 6),
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: backdropUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 60,
                      icon: const Icon(
                        Icons.play_circle_outline_sharp,
                        color: AppColors.white,
                      ),
                      onPressed: controller.launchTrailer,
                    ),
                    Text(
                      'Watch Trailer',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                genres,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  MovieInfoChip(label: certification),
                  const SizedBox(width: 8),
                  MovieInfoChip(label: releaseYear),
                  const SizedBox(width: 8),
                  MovieInfoChip(label: formattedRuntime),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
