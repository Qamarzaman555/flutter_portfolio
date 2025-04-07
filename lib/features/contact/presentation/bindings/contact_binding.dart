import 'package:get/get.dart';
import 'package:portfolio/features/contact/presentation/controllers/contact_controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
} 