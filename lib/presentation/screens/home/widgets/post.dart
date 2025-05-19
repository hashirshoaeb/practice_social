import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_social/domain/models/post.dart';

class Post extends StatefulWidget {
  const Post({super.key, required this.post});

  final PostModel post;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.network(widget.post.imageUrl, fit: BoxFit.cover),
        // Post Content Overlay
        PostContentOverlay(post: widget.post),
        // Right side interaction buttons
        InteractionOverlay(post: widget.post),
      ],
    );
  }
}

class PostContentOverlay extends StatelessWidget {
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
              // Username
              Text(
                post.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),

              // Caption
              Text(
                post.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Hashtag
              const Text(
                "#fyp",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 6),

              // Show translation
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
              // Song
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

class InteractionButton extends StatelessWidget {
  final String icon;
  final String text;
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

class InteractionOverlay extends StatelessWidget {
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                  ),
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
              InteractionButton(
                icon: 'assets/save.svg',
                text: "34k",
                onTap: () {},
              ),
              const SizedBox(height: 15),
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
