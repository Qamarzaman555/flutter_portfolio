import 'package:get/get.dart';
import 'package:portfolio/features/home/presentation/controllers/home_controller.dart';
import 'package:portfolio/features/work/presentation/controllers/work_controller.dart';
import 'package:portfolio/features/about/presentation/controllers/about_controller.dart';
import 'package:portfolio/features/contact/presentation/controllers/contact_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<WorkController>(() => WorkController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
} 