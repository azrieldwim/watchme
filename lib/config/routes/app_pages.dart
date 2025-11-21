import 'package:get/get.dart';
import 'package:watchme/modules/home/views/home_view.dart';
import 'package:watchme/modules/home/controllers/home_controller.dart';
import 'package:watchme/config/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
    ),
  ];
}
