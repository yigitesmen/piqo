import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  final bool isSecureField;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLength;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.iconData,
    required this.hintText,
    this.isSecureField = false,
    this.keyboardType,
    this.validator,
    this.maxLength = 25,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white, fontSize: 15.5),
      cursorColor: Colors.white,
      obscureText: isSecureField,
      enableSuggestions: !isSecureField,
      autocorrect: !isSecureField,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 18),
        errorStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        prefixIcon: Icon(
          iconData,
          color: Colors.white.withValues(alpha: 0.85),
          size: 21,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.25), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: Colors.white, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors.orange.shade100, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Colors.orange.shade100, width: 1.6),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.14),
        hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.75), fontSize: 15.5),
        hintText: hintText,
      ),
    );
  }
}
