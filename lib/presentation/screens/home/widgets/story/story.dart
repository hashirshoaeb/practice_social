import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'story_loader_painter.part.dart';
part 'story_item.part.dart';

/// Types of stories that can be displayed
enum StoryType { create, live, regular }

/// Main story list widget
/// Displays horizontal scrollable list of user stories
class StoryList extends StatelessWidget {
  StoryList({super.key});

  /// List of stories to display
  final List<({String name, String imageUrl, StoryType storyType})> stories = [
    (
      name: 'Create',
      imageUrl:
          'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200',
      storyType: StoryType.create,
    ),
    (
      name: 'Michelle_w...',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200',
      storyType: StoryType.live,
    ),
    (
      name: 'frankoo',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'its_doggo',
      imageUrl:
          'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'catmom',
      imageUrl:
          'https://images.unsplash.com/photo-1618826411640-d6df44dd3f7a?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'travel_guy',
      imageUrl:
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200',
      storyType: StoryType.regular,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _StoryItem(
            name: stories[index].name,
            imageUrl: stories[index].imageUrl,
            storyType: stories[index].storyType,
          );
        },
      ),
    );
  }
}
