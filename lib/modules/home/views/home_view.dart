import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchme/config/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/horizontal_movie_list.dart';
import '../widgets/main_banner.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back,',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 2),
            Text(
              'Azriel Dwi Mahendra.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list_alt, color: AppColors.white, size: 30),
          ),
        ],
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.topRatedMovies.isEmpty &&
            controller.upcomingMovies.isEmpty &&
            controller.trendingMovies.isEmpty) {
          return const Center(
            child: Text("Tidak ada data film yang ditemukan."),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainBanner(movies: controller.trendingMovies),
              HorizontalMovieSection(
                title: 'Top Movie Picks',
                movies: controller.topRatedMovies,
              ),
              HorizontalMovieSection(
                title: 'Upcoming Movies',
                movies: controller.upcomingMovies,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
