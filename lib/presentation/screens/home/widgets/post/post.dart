import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:practice_social/domain/models/post.dart';
import 'package:practice_social/presentation/screens/post/post_detail_screen.dart';

part 'post_content_overlay.part.dart';
part 'interaction_overlay.part.dart';
part 'save_button.part.dart';
part 'interaction_button.part.dart';

/// Main post widget
/// Displays post content with image, interactions, and animations
class Post extends StatefulWidget {
  /// Post data to display
  final PostModel post;

  const Post({super.key, required this.post});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image with hero animation
        Hero(
          tag: 'POST_IMAGE_${widget.post.id}',
          child: Image.network(
            widget.post.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              );
            },
          ),
        ),
        // Post content overlay
        PostContentOverlay(post: widget.post),
        // Right side interaction buttons
        // OverflowBox(
        // maxHeight: MediaQuery.of(context).size.height - 80,
        // child:
        InteractionOverlay(post: widget.post),
        // ),
      ],
    );
  }
}
