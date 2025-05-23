part of 'story.dart';

/// Individual story item widget
/// Displays user story with loading animation
class _StoryItem extends StatefulWidget {
  /// Username to display
  final String name;

  /// URL of the story image
  final String imageUrl;

  /// Type of story (create, live, or regular)
  final StoryType storyType;

  const _StoryItem({
    required this.name,
    required this.imageUrl,
    required this.storyType,
  });

  @override
  State<_StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<_StoryItem>
    with SingleTickerProviderStateMixin {
  /// Whether the story is currently loading
  bool isLoading = false;

  /// Controller for loading animation
  late AnimationController _animationController;

  /// Base animation for loading effect
  late Animation<double> base;

  /// Reverse animation for loading effect
  late Animation<double> reverse;

  /// Gap animation for loading effect
  late Animation<double> gap;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    base = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    gap = Tween<double>(begin: 0, end: 18 * 2).animate(base);
    reverse = Tween<double>(begin: 0, end: -0.15).animate(base);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        _animationController.repeat();
        await Future.delayed(const Duration(seconds: 5));
        _animationController.stop();
        _animationController.reset();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Loading animation
                _buildLoadingAnimation(70),
                // Profile image
                Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: switch (widget.storyType) {
                      StoryType.create => const Color(0xFFFF8D00),
                      _ => null,
                    },
                    border: Border.all(color: Colors.black, width: 2),
                    image: switch (widget.storyType) {
                      StoryType.create => null,
                      _ => DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    },
                  ),
                ),

                // Add button for create story
                if (widget.storyType == StoryType.create)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/add.svg',
                          width: 12,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Live badge
                if (widget.storyType == StoryType.live)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0050),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            // Username
            Text(
              widget.name,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the loading animation for the story
  Widget _buildLoadingAnimation(double size) {
    List<Color> gradientColors =
        widget.storyType == StoryType.live
            ? const [Color(0xFFFF0050), Color(0xFF7700FF)]
            : const [Color(0xFF00C2FF), Color(0xFF00E5FF)];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: size,
          height: size,
          child: RotationTransition(
            turns: reverse,
            child: CustomPaint(
              painter: StoryLoaderPainter(
                animation: _animationController.value,
                gradientColors: gradientColors,
                gapSize: gap.value,
                dashes: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
