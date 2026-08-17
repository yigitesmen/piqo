import 'package:flutter/material.dart';

import '../../utils/strings.dart';

class ImagePickerView extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double radius;

  const ImagePickerView({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    this.radius = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border:
          Border.all(color: foregroundColor, width: 2),
        ),
        width: radius,
        height: radius,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 50,
              color: foregroundColor,
            ),
            const SizedBox(height: 6),
            Text(
              AppStrings.photo,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
