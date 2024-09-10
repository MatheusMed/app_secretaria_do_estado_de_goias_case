import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Aplica a máscara
    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }
    String maskedText = '';
    if (newText.isNotEmpty) {
      maskedText += newText.substring(0, 3);
    }
    if (newText.length > 3) {
      maskedText += '.${newText.substring(3, 6)}';
    }
    if (newText.length > 6) {
      maskedText += '.${newText.substring(6, 9)}';
    }
    if (newText.length > 9) {
      maskedText += '-${newText.substring(9)}';
    }

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }
}
