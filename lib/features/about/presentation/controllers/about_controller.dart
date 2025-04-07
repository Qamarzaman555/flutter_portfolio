import 'package:get/get.dart';

class AboutController extends GetxController {
  final _skills = <String>[].obs;
  List<String> get skills => _skills;

  @override
  void onInit() {
    super.onInit();
    _loadSkills();
  }

  void _loadSkills() {
    _skills.value = [
      'Flutter',
      'Dart',
      'GetX',
      'Firebase',
      'REST APIs',
      'Git',
      'Clean Architecture',
      'UI/UX Design',
    ];
  }
} 