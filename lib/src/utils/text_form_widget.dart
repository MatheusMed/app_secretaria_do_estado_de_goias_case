// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  bool obscureText;
  final String? labelText;
  bool isReadOnly;
  TextFormWidget({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    required this.labelText,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira a data de nascimento';
        }
        return null;
      },
    );
  }
}
