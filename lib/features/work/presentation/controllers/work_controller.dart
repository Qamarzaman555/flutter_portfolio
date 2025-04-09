import 'package:get/get.dart';
import 'package:portfolio/core/services/firebase_service.dart';
import 'package:portfolio/features/work/domain/entities/project.dart';

class WorkController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  final _projects = <Project>[].obs;
  List<Project> get projects => _projects;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _error = RxnString();
  String? get error => _error.value;

  final _selectedCategory = RxnString();
  String? get selectedCategory => _selectedCategory.value;

  List<String> get categories {
    final categories =
        _projects.map((p) => p.category).whereType<String>().toSet().toList();
    categories.sort();
    return categories;
  }

  List<Project> get filteredProjects {
    if (_selectedCategory.value == null) return _projects;
    return _projects
        .where((p) => p.category == _selectedCategory.value)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    print('WorkController initialized');
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    print('Loading projects...');
    _isLoading.value = true;
    _error.value = null;

    try {
      print('Attempting to fetch projects from Firebase service...');
      final projectsList = await _firebaseService.getProjects();
      print('Successfully fetched ${projectsList.length} projects');
      _projects.value = projectsList;

      // Preload project images
      for (final project in projectsList) {
        print('Preloading images for project: ${project.title}');
        await _firebaseService.preloadProjectImages(project);
      }
    } catch (e, stackTrace) {
      print('Error in _loadProjects: $e');
      print('Stack trace: $stackTrace');
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load projects: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void setCategory(String? category) {
    print('Setting category to: $category');
    _selectedCategory.value = category;
  }

  Future<void> refresh() async {
    print('Refreshing projects...');
    await _loadProjects();
  }
}
