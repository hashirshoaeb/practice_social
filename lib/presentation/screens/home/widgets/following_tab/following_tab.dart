import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/presentation/cubit/following_tab_control_cubit/following_tab_control_cubit.dart';
import 'package:practice_social/presentation/cubit/following_tab_control_cubit/following_tab_control_state.dart';
import 'package:practice_social/presentation/cubit/post_cubit/post_cubit.dart';
import 'package:practice_social/presentation/cubit/post_cubit/post_state.dart';
import 'package:practice_social/presentation/screens/home/widgets/post/post.dart';
import 'package:practice_social/presentation/screens/home/widgets/story/story.dart';
import 'package:practice_social/presentation/shared_widgets/extent_page_view.dart';

part 'story_section_header.part.dart';
part 'post_page_view.part.dart';
part 'scrollable_header_delegate.part.dart';
part 'story_toggle_button.part.dart';

/// Main following tab widget
/// Displays stories and posts with scrollable content
class FollowingTab extends StatefulWidget {
  const FollowingTab({super.key});
  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // Load posts when tab is initialized
    context.read<PostCubit>().getPosts();
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
          // Story section header
          StorySectionHeader(),
        ];
      },
      body: Stack(
        children: [
          // Post content
          PostPageView(),
          // Story widget toggle button
          Positioned(
            top: MediaQuery.of(context).padding.top + 62,
            left: 0,
            right: 0,
            child: StoryToggleButton(),
          ),
        ],
      ),
    );
  }
}
