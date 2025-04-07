import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/features/about/presentation/controllers/about_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF121212),
      child: SingleChildScrollView(
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
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main content card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About me',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _buildParagraph(
                'In 2018, I joined medtech startup Immertec as the second hire to lead all design efforts, increasing usability by 15 points on the SUS scale, from 68 to 83, and helping the company scale to over 50 employees while securing \$12M in funding.',
              ),
              const SizedBox(height: 24),
              _buildParagraph(
                'After Immertec, I joined FCB Health NY and designed healthcare products for Fortune 100 companies used by over 5M users. Later, at Spontivly, I led design initiatives for a platform that democratized data dashboards and supported over 120 API integrations. In 2023, I joined Corellium, where I led the redesign of their virtualization platform, focusing on scalability, mobile optimization, and accessibility.',
              ),
              const SizedBox(height: 24),
              _buildParagraph(
                'I also founded Paidly in 2020, a Stripe-integrated invoicing app used by over 2,000 SMEs, and Magier in 2023, an AI startup acquired the same year and accepted into Techstars\' 2024 cohort. I\'ve also published research on accessibility and virtual environments in publications by HFES and SSH. When not designing, I\'m probably playing music.',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle let's work together action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Let's work together",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Footer with copyright and social links
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 Brendan Ciccone',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  _buildSocialIcon(Icons.linear_scale, 'LinkedIn'),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.code, 'GitHub'),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.language, 'Dribbble'),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.play_circle_fill, 'YouTube'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        height: 1.6,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return InkWell(
      onTap: () {
        // Open social media link
      },
      child: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        size: 22,
      ),
    );
  }
}