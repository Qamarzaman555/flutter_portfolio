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
    print('🔄 AboutController initialized');
    _loadAboutData();
  }

  Future<void> _loadAboutData() async {
    print('🔄 Starting to load about data...');
    _isLoading.value = true;
    _error.value = null;

    try {
      print('📥 Fetching data from Firebase service...');
      final aboutData = await _firebaseService.getAboutData();
      print('✅ Data fetched successfully:');
      print('  - Name: ${aboutData.name}');
      print('  - Title: ${aboutData.title}');
      print('  - Skills: ${aboutData.skills.length} items');
      print('  - Experiences: ${aboutData.experiences.length} items');
      print('  - Education: ${aboutData.education.length} items');

      _about.value = aboutData;
      print('✅ About data set in controller');

      // Preload profile image
      if (aboutData.profileImageUrl.isNotEmpty) {
        print('🖼️ Preloading profile image...');
        await _firebaseService.getCachedImageUrl(aboutData.profileImageUrl);
        print('✅ Profile image preloaded');
      }
    } catch (e, stackTrace) {
      print('❌ Error loading about data:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
      print('🏁 Finished loading about data');
    }
  }

  Future<void> refresh() async {
    print('🔄 Refreshing about data...');
    await _loadAboutData();
  }
}
