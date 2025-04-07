import 'package:get/get.dart';
import 'package:portfolio/features/about/presentation/controllers/about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
} 