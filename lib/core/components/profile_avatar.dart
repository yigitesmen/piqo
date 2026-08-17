import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageUrl == null
          ? const AssetImage('assets/images/default_profile_image.png')
          : CachedNetworkImageProvider(imageUrl!) as ImageProvider<Object>?,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      radius: radius,
    );
  }
}
