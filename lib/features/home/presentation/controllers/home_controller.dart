import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      _selectedIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
    tabController.animateTo(index);
  }
} 