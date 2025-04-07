// work_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/work/presentation/controllers/work_controller.dart';
import 'package:portfolio/features/work/presentation/widgets/project_card.dart';
// import 'package:google_fonts/google_fonts.dart';

class WorkPage extends GetView<WorkController> {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Projects grid 
          Expanded(
            child: Obx(
              () => controller.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : Responsive(
                      mobile: _buildProjectsGrid(context, 1),
                      tablet: _buildProjectsGrid(context, 2),
                      desktop: _buildProjectsGrid(context, 3),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: controller.projects.length,
      itemBuilder: (context, index) {
        final project = controller.projects[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ProjectCard(project: project),
          ),
        );
      },
    );
  }
}