// home_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/theme/theme_controller.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/about/presentation/pages/about_page.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/home/presentation/controllers/home_controller.dart';
import 'package:portfolio/features/work/presentation/pages/work_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: max(16, MediaQuery.of(context).size.width * 0.5 - 500),
            vertical: 16,
          ),
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile and navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile section
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              const AssetImage('assets/images/profile.jpg'),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Brendan Ciccone',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    // Navigation tabs
                    Responsive(
                      mobile: Container(), // Hidden on mobile
                      tablet: _buildNavTabs(context),
                      desktop: _buildNavTabs(context),
                    ),
                    // Action buttons
                    Row(
                      children: [
                        IconButton(
                          icon: Obx(() => Icon(
                                themeController.isDarkMode
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                              )),
                          onPressed: themeController.changeTheme,
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Handle let's chat action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            foregroundColor:
                                Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Let's chat",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Main content area
                Expanded(
                  child: Obx(() => _buildMainContent(controller.selectedIndex)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(int index) {
    switch (index) {
      case 0:
        return const WorkPage();
      case 1:
        return const AboutPage();
      case 2:
        return const ContactPage();
      default:
        return const WorkPage();
    }
  }

  Widget _buildNavButton(String label, int index, BuildContext context) {
    return Obx(() => TextButton(
          onPressed: () => controller.changeIndex(index),
          style: TextButton.styleFrom(
            backgroundColor: controller.selectedIndex == index
                ? Theme.of(context).colorScheme.onInverseSurface
                : Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: controller.selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.w400,
                  color: controller.selectedIndex == index
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.secondary,
                ),
          ),
        ));
  }

  Widget _buildNavTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavButton('Work', 0, context),
          _buildNavButton('About', 1, context),
          _buildNavButton('Contact', 2, context),
        ],
      ),
    );
  }
}
