import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class CustomInputView extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendButtonPressed;

  const CustomInputView({
    super.key,
    required this.controller,
    required this.onSendButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 0.75, thickness: 0.75),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '${AppStrings.message}...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: onSendButtonPressed,
                child: Text(AppStrings.send),
              ),
              const SizedBox(width: 2),
            ],
          ),
        ),
      ],
    );
  }
}
