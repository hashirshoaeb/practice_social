import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/domain/models/post.dart';
import 'package:practice_social/domain/post_repository.dart';
import 'package:practice_social/presentation/cubit/following_tab_control_cubit.dart';
import 'package:practice_social/presentation/screens/home/widgets/post.dart';
import 'package:practice_social/presentation/screens/home/widgets/scroll_up_gesture_recognizer.dart';
import 'package:practice_social/presentation/screens/home/widgets/scrollable_header_delegate.dart';
import 'package:practice_social/presentation/screens/home/widgets/story_list.dart';
import 'package:practice_social/presentation/shared_widgets/extent_page_view.dart';

class FollowingTab extends StatefulWidget {
  const FollowingTab({super.key});
  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab>
    with AutomaticKeepAliveClientMixin {
  final postRepository = PostRepository();
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    postRepository.getPosts().then((value) {
      setState(() {
        posts = value;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      controller: context.read<FollowingTabControlCubit>().scrollController,
      headerSliverBuilder: (context, innerBoxScrolled) {
        return [
          SliverPersistentHeader(
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
          ),
        ];
      },
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragStart: (details) {},
            onTapDown: (details) {
              // context.read<FollowingTabControlCubit>().onPageTappedDown();
            },
            child: ExtentsPageView.extents(
              physics: const PageScrollPhysics(),
              controller:
                  context.read<FollowingTabControlCubit>().pageController,
              extents: 1,
              onPageChanged: (index) {},
              itemCount: posts.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return BlocBuilder<
                  FollowingTabControlCubit,
                  FollowingTabControlState
                >(
                  builder: (context, state) {
                    final shouldScrollUpAbsorb = !state.isStoryWidgetVisible;
                    final shouldScrollDownAbsorb =
                        !state.isFirstPage && !state.isStoryWidgetVisible;
                    return ScrollUpGestureDetector(
                      onScrollUpAbsorb: shouldScrollUpAbsorb,
                      onScrollUp: () {
                        context.read<FollowingTabControlCubit>().onScrollUp();
                      },
                      onScrollDownAbsorb: shouldScrollDownAbsorb,
                      onScrollDown: () {
                        context.read<FollowingTabControlCubit>().onScrollDown();
                      },
                      child: Post(
                        key: Key(posts[index].id),
                        post: posts[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Story section with expandable animation
          Positioned(
            top: MediaQuery.of(context).padding.top + 62,
            left: 0,
            right: 0,
            child:
                BlocBuilder<FollowingTabControlCubit, FollowingTabControlState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.isStoryWidgetVisible ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTapUp: (details) {
                            context
                                .read<FollowingTabControlCubit>()
                                .onViewStoryTapped();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Stories",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
