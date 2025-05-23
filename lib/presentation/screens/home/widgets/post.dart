import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:practice_social/domain/models/post.dart';
import 'package:practice_social/presentation/screens/post/post_detail_screen.dart';

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

/// Overlay widget for post content
/// Displays username, caption, and music information
class PostContentOverlay extends StatelessWidget {
  /// Post data to display
  final PostModel post;

  const PostContentOverlay({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username with hero animation
              Hero(
                tag: 'POST_TITLE_${post.id}',
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Caption with navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailScreen(post: post),
                    ),
                  );
                },
                child: Text(
                  post.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // Hashtag
              const Text(
                "#fyp",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 6),

              // Translation option
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/translate.svg',
                    height: 18,
                    width: 18,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Show translation",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Music information
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/music.svg',
                    height: 18,
                    width: 18,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.music,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Interactive button for post actions
/// Displays icon and count with tap functionality
class InteractionButton extends StatelessWidget {
  /// Icon asset path
  final String icon;

  /// Text to display
  final String text;

  /// Callback for tap events
  final VoidCallback onTap;

  const InteractionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: 30,
          width: 30,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Overlay widget for post interactions
/// Displays user avatar and interaction buttons
class InteractionOverlay extends StatelessWidget {
  /// Post data to display
  final PostModel post;

  const InteractionOverlay({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User avatar with hero animation
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: 'POST_USER_${post.id}',
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  // Add button
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/add.svg',
                        height: 12,
                        width: 12,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 15),
              // Interaction buttons
              InteractionButton(
                icon: 'assets/heart.svg',
                text: post.likeCount,
                onTap: () {},
              ),
              const SizedBox(height: 15),
              InteractionButton(
                icon: 'assets/comment.svg',
                text: post.commentCount,
                onTap: () {},
              ),
              const SizedBox(height: 15),
              InteractionButton(
                icon: 'assets/share.svg',
                text: post.shareCount,
                onTap: () {},
              ),
              const SizedBox(height: 15),
              SaveButton(),
              const SizedBox(height: 15),
              // Music disk
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/music_disk.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Animated save button with Lottie animation
class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> with TickerProviderStateMixin {
  /// Controller for Lottie animation
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        // Haptic feedback
        HapticFeedback.lightImpact();
      },
      child: Column(
        children: [
          LottieBuilder.asset(
            'assets/save.json',
            height: 60,
            width: 60,
            controller: _animationController,
            animate: false,
            reverse: false,
            repeat: false,
          ),
          const SizedBox(height: 8),
          Text(
            "34k",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
