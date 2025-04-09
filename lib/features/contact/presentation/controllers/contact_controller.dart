import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  final _nameFocusNode = FocusNode();
  FocusNode get nameFocusNode => _nameFocusNode;

  final _emailFocusNode = FocusNode();
  FocusNode get emailFocusNode => _emailFocusNode;

  final _companyFocusNode = FocusNode();
  FocusNode get companyFocusNode => _companyFocusNode;

  final _messageFocusNode = FocusNode();
  FocusNode get messageFocusNode => _messageFocusNode;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onClose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _companyFocusNode.dispose();
    _messageFocusNode.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _isLoading.value = true;
      try {
        await Future.delayed(const Duration(seconds: 2));
        Get.snackbar(
          'Success',
          'Message sent successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        _clearForm();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to send message. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isLoading.value = false;
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
}
