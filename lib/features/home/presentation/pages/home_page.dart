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
          child: Column(
            children: [
              // Header
              Responsive(
                mobile: _buildMobileHeader(context, themeController),
                tablet: _buildDesktopHeader(context, themeController),
                desktop: _buildDesktopHeader(context, themeController),
              ),

              // Main content area
              Expanded(
                child: Obx(() => _buildMainContent(controller.selectedIndex)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileHeader(
      BuildContext context, ThemeController themeController) {
    return Column(
      children: [
        // Profile section
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Obx(() => Text(
                    controller.initials,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      )),
                  Obx(() => Text(
                        controller.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7),
                            ),
                      )),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: themeController.changeTheme,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Navigation tabs
        _buildNavTabs(context),
        const SizedBox(height: 16),
        // Chat button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's chat",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(
      BuildContext context, ThemeController themeController) {
    return Row(
      children: [
        // Profile section
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Obx(() => Text(
                    controller.initials,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  )),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      controller.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    )),
                Obx(() => Text(
                      controller.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                          ),
                    )),
              ],
            ),
          ],
        ),
        const Spacer(),
        // Navigation tabs
        _buildNavTabs(context),
        const Spacer(),
        // Chat button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Let's chat",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                size: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(
            themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: themeController.changeTheme,
        ),
      ],
    );
  }

  Widget _buildNavTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
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

  Widget _buildNavButton(String label, int index, BuildContext context) {
    return Obx(() => TextButton(
          onPressed: () => controller.changeIndex(index),
          style: TextButton.styleFrom(
            backgroundColor: controller.selectedIndex == index
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: controller.selectedIndex == index
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: controller.selectedIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                ),
          ),
        ));
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
}
