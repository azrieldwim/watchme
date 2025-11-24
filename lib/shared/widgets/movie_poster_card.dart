import 'package:flutter/material.dart';
import 'package:watchme/data/services/api_config.dart';
import '../../../data/models/movie_model.dart';
import '../../utils/app_utils.dart';

class MoviePosterCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;

  const MoviePosterCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String posterUrl = '${ApiConfig.imageBaseUrl}${movie.posterPath}';
    final String rating = movie.rating.toStringAsFixed(1);
    final String releaseYear = movie.releaseDate.split('-').first;
    final String formattedRuntime = formatRuntime(movie.runtime);
    final String certification = movie.certification ?? 'NA';
    final String detailText =
        '$releaseYear • $certification • $formattedRuntime';

    const double cardWidth = 130.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image: posterUrl,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.white70,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          rating,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              detailText,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
