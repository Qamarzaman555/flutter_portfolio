import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/features/contact/presentation/controllers/contact_controller.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactController controller = Get.find<ContactController>();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Unfocus any text field when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const Text(
                    "Let's go to market",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Ready to take your product from 0 → 1 or looking to expand your team?\nReach out below.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade800),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Name'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: controller.nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              focusNode: controller.nameFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(controller.emailFocusNode);
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildLabel('Email'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: controller.emailController,
                              focusNode: controller.emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (_) {
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
                            _buildLabel('Company'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              focusNode: controller.companyFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(controller.messageFocusNode);
                              },
                              hintText: 'Optional',
                            ),
                            const SizedBox(height: 20),
                            _buildLabel('Message'),
                            const SizedBox(height: 8),
                            _buildTextField(
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
                                        Colors.grey.shade700),
                                    checkColor: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'I accept this information will be used to contact me.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Obx(
                                () => ElevatedButton.icon(
                                  onPressed: controller.isLoading
                                      ? null
                                      : () {
                                          // Unfocus before submitting
                                          FocusScope.of(context).unfocus();
                                          controller.submitForm();
                                        },
                                  icon: const Icon(Icons.send_outlined),
                                  label: controller.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text('Send message'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade600,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor:
                                        Colors.grey.shade800,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '© 2025 Brendan Ciccone',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.link, color: Colors.grey.shade500),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.code, color: Colors.grey.shade500),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.language, color: Colors.grey.shade500),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.play_circle_outline,
                            color: Colors.grey.shade500),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
