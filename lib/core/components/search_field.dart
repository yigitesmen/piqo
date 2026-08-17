import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String) onChanged;

  const SearchField({
    super.key,
    this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).appBarTheme.backgroundColor,
        hintText: '${AppStrings.search}...',
      ),
    );
  }
}
