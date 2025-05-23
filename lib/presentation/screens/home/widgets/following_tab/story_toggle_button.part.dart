part of 'following_tab.dart';

/// Story toggle button widget
/// Displays the story toggle button
class StoryToggleButton extends StatelessWidget {
  const StoryToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowingTabControlCubit, FollowingTabControlState>(
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: state.isStoryWidgetVisible ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTapUp: (details) {
                context.read<FollowingTabControlCubit>().onViewStoryTapped();
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
    );
  }
}
