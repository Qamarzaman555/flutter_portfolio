// home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/theme/theme_controller.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/about/presentation/pages/about_page.dart';
import 'package:portfolio/features/contact/presentation/pages/contact_page.dart';
import 'package:portfolio/features/home/presentation/controllers/home_controller.dart';
import 'package:portfolio/features/work/presentation/pages/work_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                        backgroundImage: const AssetImage('assets/images/profile.jpg'),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Brendan Ciccone',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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
                          themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: Colors.white,
                        )),
                        onPressed: themeController.changeTheme,
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Handle let's chat action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Let's chat",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                              ),
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
              
              // Title section
              const SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  children: const [
                    TextSpan(text: '0 → 1 Senior Product Designer'),
                  ],
                ),
              ),
              
              const SizedBox(height: 8),
              Text(
                'with 7 years of experience turning ideas into fully realized B2B and B2C products across healthcare, cybersecurity, and finance.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              
              const SizedBox(height: 24),
              
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
  
  Widget _buildNavTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavButton('Work', 0),
          _buildNavButton('About', 1),
          _buildNavButton('Contact', 2),
        ],
      ),
    );
  }
  
  Widget _buildNavButton(String label, int index) {
    return Obx(() => TextButton(
      onPressed: () => controller.changeIndex(index),
      style: TextButton.styleFrom(
        backgroundColor: controller.selectedIndex == index 
            ? Colors.white 
            : Colors.transparent,
        foregroundColor: controller.selectedIndex == index 
            ? Colors.black 
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
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