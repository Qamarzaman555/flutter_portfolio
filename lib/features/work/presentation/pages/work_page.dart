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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Projects grid
          Expanded(
            child: Obx(
              () => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
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
    return Column(children: [
      Column(
        children: [
          // Title section
          const SizedBox(height: 32),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              children: const [
                TextSpan(text: '0 → 1 Senior Product Designer'),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Text(
            'with 7 years of experience turning ideas into fully realized B2B and B2C products across healthcare, cybersecurity, and finance.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 24),
        ],
      ),
      Flexible(
          child: GridView.builder(
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
            child: Card(
              child: ProjectCard(project: project),
            ),
          );
        },
      ))
    ]);
  }
}
