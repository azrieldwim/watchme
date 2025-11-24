import 'package:get/get.dart';
import 'package:watchme/config/routes/app_routes.dart';
import 'package:watchme/modules/detail/bindings/detail_binding.dart';
import 'package:watchme/modules/detail/views/detail_view.dart';
import 'package:watchme/modules/main/bindings/main_binding.dart';
import 'package:watchme/modules/main/views/main_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),

    GetPage(
      name: Routes.detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
