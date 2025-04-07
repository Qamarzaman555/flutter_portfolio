import 'package:get/get.dart';
import 'package:portfolio/features/work/presentation/controllers/work_controller.dart';

class WorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkController>(() => WorkController());
  }
} 