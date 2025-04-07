import 'package:get/get.dart';
import 'package:portfolio/features/work/domain/entities/project.dart';

class WorkController extends GetxController {
  final _projects = <Project>[].obs;
  List<Project> get projects => _projects;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }

  void _loadProjects() {
    _isLoading.value = true;
    _projects.value = [
      Project(
        id: '1',
        title: 'E-Commerce App',
        description: 'A full-featured e-commerce application with payment integration and user authentication.',
        imageUrl: '',
        technologies: ['Flutter', 'Firebase', 'Stripe', 'GetX'],
        githubUrl: 'https://github.com/username/ecommerce',
        liveUrl: 'https://ecommerce.example.com',
      ),
      Project(
        id: '2',
        title: 'Social Media Dashboard',
        description: 'A dashboard for managing social media accounts with analytics and scheduling features.',
        imageUrl: '',
        technologies: ['Flutter', 'REST API', 'Charts', 'Local Storage'],
        githubUrl: 'https://github.com/username/social-dashboard',
      ),
      Project(
        id: '3',
        title: 'Fitness Tracker',
        description: 'A comprehensive fitness tracking app with workout plans and progress monitoring.',
        imageUrl: '',
        technologies: ['Flutter', 'SQLite', 'Bloc', 'Maps'],
        githubUrl: 'https://github.com/username/fitness-tracker',
        liveUrl: 'https://fitness.example.com',
      ),
      Project(
        id: '4',
        title: 'Weather App',
        description: 'A beautiful weather application with location-based forecasts and weather alerts.',
        imageUrl: '',
        technologies: ['Flutter', 'OpenWeather API', 'Provider', 'Animations'],
        githubUrl: 'https://github.com/username/weather-app',
      ),
    ];
    _isLoading.value = false;
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