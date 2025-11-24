import 'package:get/get.dart';
import 'package:watchme/modules/detail/controllers/detail_controller.dart';


class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}