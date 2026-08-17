import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/bouncing_animation.dart';

class PostImage extends StatefulWidget {
  final VoidCallback onDoubleTap;
  final String imageUrl;

  const PostImage({
    super.key,
    required this.onDoubleTap,
    required this.imageUrl,
  });

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  bool isLiked = false;
  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        widget.onDoubleTap();
        setState(() {
          isLiked = true;
          isAnimating = true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 620),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Opacity(
            opacity: isAnimating ? 1 : 0,
            child: BouncingAnimation(
              isAnimating: isAnimating,
              duration: const Duration(milliseconds: 700),
              onEnd: () => setState(() => isAnimating = false),
              child: const FaIcon(
                FontAwesomeIcons.solidHeart,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}