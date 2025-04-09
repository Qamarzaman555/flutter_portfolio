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
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final projectsList = await _firebaseService.getProjects();
      _projects.value = projectsList;

      // Preload project images
      for (final project in projectsList) {
        await _firebaseService.preloadProjectImages(project);
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  void setCategory(String? category) {
    _selectedCategory.value = category;
  }

  Future<void> refresh() async {
    await _loadProjects();
  }
}

class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
  });
}
