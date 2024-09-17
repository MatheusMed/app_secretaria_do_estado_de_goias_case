import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }

    String maskedText = '';

    if (newText.isNotEmpty) {
      maskedText +=
          newText.substring(0, newText.length > 3 ? 3 : newText.length);
    }
    if (newText.length > 3) {
      maskedText +=
          '.${newText.substring(3, newText.length > 6 ? 6 : newText.length)}';
    }
    if (newText.length > 6) {
      maskedText +=
          '.${newText.substring(6, newText.length > 9 ? 9 : newText.length)}';
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
