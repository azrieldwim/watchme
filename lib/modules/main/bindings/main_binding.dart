import 'package:get/get.dart';
import 'package:watchme/data/services/api_service.dart';
import 'package:watchme/data/services/movie_service.dart';
import 'package:watchme/modules/home/controllers/home_controller.dart';
import 'package:watchme/modules/search/controllers/search_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());

    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<MovieService>(MovieService(), permanent: true);

    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<SearchMovieController>(SearchMovieController(), permanent: true);
  }
}
