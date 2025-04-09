import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/about/presentation/controllers/about_controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Responsive(
        mobile: _buildContent(context),
        tablet: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: _buildContent(context),
          ),
        ),
        desktop: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'About me',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildParagraph(context,
                    'In 2018, I joined medtech startup Immertec as the second hire to lead all design efforts, increasing usability by 15 points on the SUS scale, from 68 to 83, and helping the company scale to over 50 employees while securing \$12M in funding.'),
                const SizedBox(height: 24),
                _buildParagraph(context,
                    'After Immertec, I joined FCB Health NY and designed healthcare products for Fortune 100 companies used by over 5M users. Later, at Spontivly, I led design initiatives for a platform that democratized data dashboards and supported over 120 API integrations. In 2023, I joined Corellium, where I led the redesign of their virtualization platform, focusing on scalability, mobile optimization, and accessibility.'),
                const SizedBox(height: 24),
                _buildParagraph(context,
                    'I also founded Paidly in 2020, a Stripe-integrated invoicing app used by over 2,000 SMEs, and Magier in 2023, an AI startup acquired the same year and accepted into Techstars\' 2024 cohort. I\'ve also published research on accessibility and virtual environments in publications by HFES and SSH. When not designing, I\'m probably playing music.'),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Let's work together",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        const SizedBox(width: 8),
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
            ),
          ),

          // Footer with copyright and social links
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 Brendan Ciccone',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                      ),
                ),
                Row(
                  children: [
                    _buildSocialIcon(context, Icons.linear_scale, 'LinkedIn'),
                    const SizedBox(width: 16),
                    _buildSocialIcon(context, Icons.code, 'GitHub'),
                    const SizedBox(width: 16),
                    _buildSocialIcon(context, Icons.language, 'Dribbble'),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                        context, Icons.play_circle_fill, 'YouTube'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        // Open social media link
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          size: 20,
        ),
      ),
    );
  }
}
