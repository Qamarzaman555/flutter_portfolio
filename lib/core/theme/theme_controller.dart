import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDarkMode = true.obs;
  
  bool get isDarkMode => _isDarkMode.value;
  
  void changeTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
  
  @override
  void onInit() {
    super.onInit();
    Get.changeThemeMode(ThemeMode.dark);
  }
}