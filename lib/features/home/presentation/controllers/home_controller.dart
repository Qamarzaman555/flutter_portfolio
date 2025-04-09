import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/services/firebase_service.dart';
import 'package:portfolio/features/about/domain/entities/about.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  // Reactive state variables
  final _name = ''.obs;
  final _title = ''.obs;
  final _initials = ''.obs;

  // Getters
  String get name => _name.value;
  String get title => _title.value;
  String get initials => _initials.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _error = RxnString();
  String? get error => _error.value;

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    print('HomeController initialized');
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      _selectedIndex.value = tabController.index;
    });
    _loadAboutData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> _loadAboutData() async {
    print('Loading about data...');
    _isLoading.value = true;
    _error.value = null;

    try {
      print('Attempting to fetch about data from Firebase service...');
      final aboutData = await _firebaseService.getAboutData();
      print(
          'Successfully fetched about data: ${aboutData.name}, ${aboutData.title}');
      _updateProfileData(aboutData);
    } catch (e, stackTrace) {
      print('Error in _loadAboutData: $e');
      print('Stack trace: $stackTrace');
      _error.value = e.toString();
      _setDefaultValues();
      Get.snackbar(
        'Error',
        'Failed to load profile data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void _updateProfileData(About about) {
    print('Updating profile data...');
    _name.value = about.name;
    _title.value = about.title;
    _initials.value =
        about.name.isNotEmpty ? about.name.substring(0, 2).toUpperCase() : 'BC';
    print(
        'Profile data updated: name=${_name.value}, title=${_title.value}, initials=${_initials.value}');
  }

  void _setDefaultValues() {
    print('Setting default values...');
    _name.value = 'Brendan Ciccone';
    _title.value = 'Product Designer';
    _initials.value = 'BC';
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
    tabController.animateTo(index);
  }

  Future<void> refresh() async {
    print('Refreshing about data...');
    await _loadAboutData();
  }
}
