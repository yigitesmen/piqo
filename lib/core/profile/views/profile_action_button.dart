import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final VoidCallback didTap;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const ProfileActionButton({
    super.key,
    required this.didTap,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: didTap,
      child: Container(
        decoration: BoxDecoration(
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        height: 30,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: foregroundColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}