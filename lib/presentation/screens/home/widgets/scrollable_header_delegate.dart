import 'package:flutter/material.dart';

class ScrollableHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final double visibleSpaceHeight;

  ScrollableHeaderDelegate({
    required this.child,
    required this.visibleSpaceHeight,
  });

  final ScrollController controller = ScrollController();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // final progress = shrinkOffset / maxExtent;
    // bool isMinimized = (shrinkOffset >= (maxExtent - minExtent));
    return OverflowBox(
      maxHeight: maxExtent,
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => visibleSpaceHeight;

  @override
  bool shouldRebuild(covariant ScrollableHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.visibleSpaceHeight != visibleSpaceHeight;
  }
}
