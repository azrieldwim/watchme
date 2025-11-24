import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/config/routes/app_routes.dart';
import 'package:watchme/config/theme/app_colors.dart';
import '../../../../data/models/movie_model.dart';
import '../../../../shared/widgets/movie_poster_card.dart';

class HorizontalMovieSection extends StatelessWidget {
  final String title;
  final RxList<MovieModel> movies;

  const HorizontalMovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MoviePosterCard(
                    movie: movie,
                    onTap: () {
                      Get.toNamed(Routes.detail, arguments: movie.id);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
