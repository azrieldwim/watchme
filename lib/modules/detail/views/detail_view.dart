import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/modules/detail/widgets/detail_credits_section.dart';
import 'package:watchme/modules/detail/widgets/detail_movie_section.dart';
import 'package:watchme/modules/detail/widgets/detail_rating_section.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: GetBuilder<DetailController>(
        builder: (controller) {
          final movie = controller.movie.value;
          if (controller.isLoading.isTrue || movie == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailMovieSection(movie: movie),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Add To Watchlist',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DetailRatingSection(movie: movie),
                  const SizedBox(height: 20),
                  DetailCreditsSection(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
