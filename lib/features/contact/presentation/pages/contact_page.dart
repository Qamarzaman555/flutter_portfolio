import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/features/contact/presentation/controllers/contact_controller.dart';
import 'package:portfolio/features/about/presentation/controllers/about_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/core/utils/responsive.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactController controller = Get.find<ContactController>();
    final AboutController aboutController = Get.find<AboutController>();

    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Responsive(
            mobile: _buildContent(context, controller, aboutController),
            tablet: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: _buildContent(context, controller, aboutController),
              ),
            ),
            desktop: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: _buildContent(context, controller, aboutController),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ContactController controller,
      AboutController aboutController) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Get in touch',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Let's go to market",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Ready to take your product from 0 → 1 or looking to expand your team?\nReach out below.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.8),
                      height: 1.6,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(context, 'Name'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    context,
                    controller: controller.nameController,
                    focusNode: controller.nameFocusNode,
                    onFieldSubmitted: (_) {
                      controller.nameFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(controller.emailFocusNode);
                    },
                    autoFocus: true,
                  ),
                  const SizedBox(height: 20),
                  _buildLabel(context, 'Email'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    context,
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) {
                      controller.emailFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(controller.messageFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildLabel(context, 'Company'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    context,
                    focusNode: controller.companyFocusNode,
                    onFieldSubmitted: (_) {
                      controller.companyFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(controller.messageFocusNode);
                    },
                    hintText: 'Optional',
                  ),
                  const SizedBox(height: 20),
                  _buildLabel(context, 'Message'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    context,
                    controller: controller.messageController,
                    focusNode: controller.messageFocusNode,
                    hintText: 'Tell me about your project or idea...',
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primary),
                          checkColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'I accept this information will be used to contact me.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () => ElevatedButton.icon(
                        onPressed: controller.isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                controller.submitForm();
                              },
                        icon: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send_outlined),
                        label: controller.isLoading
                            ? const SizedBox.shrink()
                            : Text(
                                'Send message',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
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
              Obx(() {
                final about = aboutController.about;
                return Text(
                  '© 2025 ${about?.name ?? 'Qamar Zaman'}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                      ),
                );
              }),
              Obx(() {
                final about = aboutController.about;
                if (about == null) return const SizedBox.shrink();

                return Row(
                  children: [
                    _buildSocialIcon(
                      context,
                      Icons.link,
                      'LinkedIn',
                      about.socialLinks['linkedin'],
                    ),
                    const SizedBox(width: 8),
                    _buildSocialIcon(
                      context,
                      Icons.code,
                      'GitHub',
                      about.socialLinks['github'],
                    ),
                    const SizedBox(width: 8),
                    _buildSocialIcon(
                      context,
                      Icons.language,
                      'Dribbble',
                      about.socialLinks['dribbble'],
                    ),
                    const SizedBox(width: 8),
                    _buildSocialIcon(
                      context,
                      Icons.play_circle_outline,
                      'YouTube',
                      about.socialLinks['youtube'],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    bool autoFocus = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildSocialIcon(
      BuildContext context, IconData icon, String label, String? url) {
    return IconButton(
      icon: Icon(icon,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
      onPressed: url != null
          ? () async {
              try {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not open $label link'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Error opening $label link: ${e.toString()}'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              }
            }
          : null,
      tooltip: url != null ? 'Open $label' : '$label link not available',
    );
  }
}
