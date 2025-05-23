part of 'post.dart';

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
