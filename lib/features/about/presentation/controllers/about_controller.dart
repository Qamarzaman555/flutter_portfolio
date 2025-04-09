import 'package:get/get.dart';
import 'package:portfolio/core/services/firebase_service.dart';
import 'package:portfolio/features/about/domain/entities/about.dart';

class AboutController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  final _about = Rxn<About>();
  About? get about => _about.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _error = RxnString();
  String? get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    _loadAboutData();
  }

  Future<void> _loadAboutData() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final aboutData = await _firebaseService.getAboutData();
      _about.value = aboutData;

      // Preload profile image
      if (aboutData.profileImageUrl.isNotEmpty) {
        await _firebaseService.getCachedImageUrl(aboutData.profileImageUrl);
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refresh() async {
    await _loadAboutData();
  }
}
