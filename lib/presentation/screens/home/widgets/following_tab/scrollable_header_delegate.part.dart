part of 'following_tab.dart';

/// Delegate for creating scrollable headers with custom behavior
/// Handles header sizing and scroll effects
class ScrollableHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// Widget to display in the header
  final PreferredSizeWidget child;

  /// Height of the visible space when header is collapsed
  final double visibleSpaceHeight;

  /// Creates a new ScrollableHeaderDelegate
  ScrollableHeaderDelegate({
    required this.child,
    required this.visibleSpaceHeight,
  });

  /// Controller for managing scroll position
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
