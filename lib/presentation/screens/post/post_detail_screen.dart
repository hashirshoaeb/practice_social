import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_social/domain/models/post.dart';

/// Unused screen (no focus on UI, just for Hero animations purposes)
/// Screen widget that displays detailed information about a post
/// Includes post content, interactions, and comments
class PostDetailScreen extends StatefulWidget {
  /// The post to be displayed
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  /// Controller for managing the comment input field
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Custom App Bar with user info and actions
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // User avatar with hero animation
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: ClipOval(
                      child: Hero(
                        tag: 'POST_USER_${widget.post.id}',
                        child: Image.network(
                          'https://picsum.photos/100',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Post title with hero animation
                  Hero(
                    tag: 'POST_TITLE_${widget.post.id}',
                    child: Text(
                      widget.post.title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Follow button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Follow",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Search icon
                  SvgPicture.asset(
                    'assets/search.svg',
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post image with hero animation
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Hero(
                      tag: 'POST_IMAGE_${widget.post.id}',
                      child: Image.network(
                        widget.post.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Interaction buttons (like, comment, share, save)
                  _buildInteractionBar(),

                  // Post details and content
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Like count display
                        Text(
                          "${widget.post.likeCount} likes",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Username and caption with rich text
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${widget.post.title} ",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: widget.post.content,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              const WidgetSpan(
                                child: Text(
                                  " 🔥",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Tags and mentions
                        const Text(
                          "@FOUNDERS TABLE @Jacques Greeff @frankgreeff",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                        const SizedBox(height: 16),

                        // Music information display
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.grey.shade800),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/music.svg',
                                height: 16,
                                width: 16,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.post.music,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Comments section header
                        const Text(
                          "View all ${101} comments",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 16),

                        // Post timestamp
                        const Text(
                          "7 weeks ago",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Comment input bar
          _buildCommentBar(),
        ],
      ),
    );
  }

  /// Builds the interaction bar with like, comment, share, and save buttons
  Widget _buildInteractionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Like button
              SvgPicture.asset(
                'assets/heart.svg',
                height: 28,
                width: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              // Comment button
              SvgPicture.asset(
                'assets/comment.svg',
                height: 28,
                width: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              // Share button
              SvgPicture.asset(
                'assets/share.svg',
                height: 28,
                width: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          // Save button
          SvgPicture.asset(
            'assets/save.svg',
            height: 28,
            width: 28,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  /// Builds the comment input bar at the bottom of the screen
  Widget _buildCommentBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.grey.shade900, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // User avatar
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          // Comment input field
          Expanded(
            child: TextField(
              controller: _commentController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Add comment...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
