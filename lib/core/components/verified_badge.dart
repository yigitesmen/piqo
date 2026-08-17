import 'package:flutter/material.dart';

class VerifiedBadge extends StatelessWidget {
  final double radius;
  final double horizontalMargin;

  const VerifiedBadge({
    super.key,
    this.radius = 17,
    this.horizontalMargin = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Image.asset(
        'assets/images/blue_tick.png',
        width: radius,
        height: radius,
      ),
    );
  }
}
