import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Config {
  static const emailJsServiceId = 'service_qamar';
  static const emailJsTemplateId = 'template_hthzui2';
  static const userId = 'VLQP5oO68IzIGCYYK';
}

class ContactController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  final _companyController = TextEditingController();
  TextEditingController get companyController => _companyController;

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
    _companyController.dispose();
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
        const serviceId = Config.emailJsServiceId;
        const templateId = Config.emailJsTemplateId;
        const userId = Config.userId;

        final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'from_name': _nameController.text,
              'to_name': 'Qamar Zaman',
              'user_email': _emailController.text,
              'company': _companyController.text,
              'message': _messageController.text,
            },
          }),
        );

        if (response.statusCode == 200) {
          Get.snackbar(
            'Success',
            'Message sent successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          _clearForm();
        } else {
          throw Exception('Failed to send email: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending email: $e');
        Get.snackbar(
          'Error',
          'Failed to send message. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
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
    _companyController.clear();
  }
}
