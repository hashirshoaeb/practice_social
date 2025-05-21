import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: [
          // Create Story Item
          _StoryItem(
            name: 'Create',
            imageUrl:
                'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200',
            isCreateStory: true,
          ),
          // Live Story Item
          _StoryItem(
            name: 'Michelle_w...',
            imageUrl:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200',
            isLive: true,
          ),
          // Regular Story Items
          _StoryItem(
            name: 'frankoo',
            imageUrl:
                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200',
          ),
          _StoryItem(
            name: 'its_doggo',
            imageUrl:
                'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=200',
          ),
          _StoryItem(
            name: 'catmom',
            imageUrl:
                'https://images.unsplash.com/photo-1618826411640-d6df44dd3f7a?q=80&w=200',
          ),
          _StoryItem(
            name: 'travel_guy',
            imageUrl:
                'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200',
          ),
        ],
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isLive;
  final bool isCreateStory;

  const _StoryItem({
    required this.name,
    required this.imageUrl,
    this.isLive = false,
    this.isCreateStory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Story border
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      isLive
                          ? const LinearGradient(
                            colors: [Color(0xFFFF0050), Color(0xFF7700FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : isCreateStory
                          ? null
                          : const LinearGradient(
                            colors: [Color(0xFF00C2FF), Color(0xFF00E5FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                ),
              ),

              // Profile image
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCreateStory ? const Color(0xFFFF8D00) : null,
                  border: Border.all(color: Colors.black, width: 2),
                  image:
                      isCreateStory
                          ? null
                          : DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                ),
              ),

              // Add button for create story
              if (isCreateStory)
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
              if (isLive)
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
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
