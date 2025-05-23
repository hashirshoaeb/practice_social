part of 'following_tab.dart';

/// Story section header widget
/// Displays the story list
class StorySectionHeader extends StatelessWidget {
  const StorySectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: ScrollableHeaderDelegate(
        visibleSpaceHeight: 0,
        child: PreferredSize(
          preferredSize: Size.fromHeight(
            context.read<FollowingTabControlCubit>().storyWidgetHeight,
          ),
          child: Column(children: [SizedBox(height: 110), StoryList()]),
        ),
      ),
    );
  }
}
