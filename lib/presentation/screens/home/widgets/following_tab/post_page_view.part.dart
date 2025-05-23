part of 'following_tab.dart';

/// Post page view widget
/// Displays the posts in a page view
class PostPageView extends StatelessWidget {
  const PostPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: FlutterLogo(size: 200));
        }

        if (state is PostLoaded) {
          return BlocBuilder<
            FollowingTabControlCubit,
            FollowingTabControlState
          >(
            builder: (context, tabState) {
              return Listener(
                onPointerMove: (event) {
                  // Handle scroll gestures
                  if (event.delta.dy < 0) {
                    context.read<FollowingTabControlCubit>().onScrollUp();
                  }
                  if (event.delta.dy > 0) {
                    context.read<FollowingTabControlCubit>().onScrollDown();
                  }
                },
                child: AbsorbPointer(
                  absorbing: tabState.isStoryWidgetVisible,
                  child: ExtentsPageView.extents(
                    physics: const PageScrollPhysics(),
                    controller:
                        context.read<FollowingTabControlCubit>().pageController,
                    extents: 1,
                    onPageChanged: (index) {},
                    itemCount: state.posts.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Post(
                        key: Key(state.posts[index].id),
                        post: state.posts[index],
                      );
                    },
                  ),
                ),
              );
            },
          );
        }

        return const Center(child: Text('No posts available'));
      },
    );
  }
}
