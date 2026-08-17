import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final VoidCallback onTap;
  final String normalText;
  final String boldText;

  const BottomNavigator({
    super.key,
    required this.onTap,
    required this.normalText,
    required this.boldText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            text: normalText,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                text: '  $boldText',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
