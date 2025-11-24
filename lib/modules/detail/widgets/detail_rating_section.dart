import 'package:flutter/material.dart';
import 'package:watchme/config/theme/app_colors.dart';
import 'package:watchme/data/models/movie_model.dart';

class DetailRatingSection extends StatelessWidget {
  final MovieModel movie;

  const DetailRatingSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Overall Rating',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              movie.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(children: _buildStarIcons(movie.rating)),
          ],
        ),
        Container(width: 1, height: 60, color: AppColors.white),
        Column(
          children: [
            Text('Your Rating', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('0.0', style: Theme.of(context).textTheme.headlineSmall),
            const Row(
              children: [
                Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
                Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
                Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
                Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
                Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildStarIcons(double rating) {
    const int maxStars = 5;
    List<Widget> icons = [];
    final double normalizedRating = rating / 2.0;

    for (int i = 1; i <= maxStars; i++) {
      if (i <= normalizedRating) {
        icons.add(
          const Icon(Icons.star, color: AppColors.yellowStar, size: 16),
        );
      } else if (i - 0.5 <= normalizedRating) {
        icons.add(
          const Icon(Icons.star_half, color: AppColors.yellowStar, size: 16),
        );
      } else {
        icons.add(
          const Icon(Icons.star_border, color: AppColors.yellowStar, size: 16),
        );
      }
    }
    return icons;
  }
}
