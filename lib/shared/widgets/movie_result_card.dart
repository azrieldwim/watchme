import 'package:flutter/material.dart';
import 'package:watchme/shared/widgets/movie_info_chip.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/services/api_config.dart';
import '../../utils/app_utils.dart';
import '../../../config/theme/app_colors.dart';

class MovieResultCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;
  final VoidCallback onWatchlistTap;

  const MovieResultCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onWatchlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final String posterUrl = '${ApiConfig.imageBaseUrl}${movie.posterPath}';
    final String releaseYear = movie.releaseDate.split('-').first;
    final String formattedRuntime = formatRuntime(movie.runtime);
    final String certification = movie.certification ?? 'N/A';
    final String genres = (movie.genres ?? ['N/A']).take(4).join(' • ');

    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: posterUrl,
                fit: BoxFit.fill,
                height: 154,
                imageErrorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 154,
                      color: Colors.grey[800],
                      child: const Icon(Icons.movie, color: Colors.white54),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 12.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      genres,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.yellowStar,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: onWatchlistTap,
                          style: ElevatedButton.styleFrom(
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
                            'Add to Watchlist',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.white),
                          ),
                        ),
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
}
