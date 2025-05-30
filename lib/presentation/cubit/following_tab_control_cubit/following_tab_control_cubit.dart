import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/presentation/cubit/following_tab_control_cubit/following_tab_control_state.dart';

/// Cubit responsible for managing the following tab's UI state and interactions
/// Handles story widget animations and page navigation
class FollowingTabControlCubit extends Cubit<FollowingTabControlState> {
  /// Controller for managing scroll position
  late final ScrollController scrollController;

  /// Controller for managing pageview navigation
  late final PageController pageController;

  /// Height of the story widget in pixels
  double get storyWidgetHeight => 228;

  /// Creates a new FollowingTabControlCubit
  /// Initializes controllers and sets up page change listener
  FollowingTabControlCubit() : super(FollowingTabControlState()) {
    scrollController = ScrollController(initialScrollOffset: storyWidgetHeight);
    pageController = PageController();
    pageController.addListener(_onPageChange);
  }

  /// Called when the story widget is tapped
  /// Shows the story widget if it's not visible
  void onViewStoryTapped() {
    if (!state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: true);
    }
  }

  /// Listener for page changes
  /// Updates state based on current page position
  void _onPageChange() {
    if (pageController.page == 0.0) {
      emit(state.copyWith(isFirstPage: true));
    } else {
      // do not re emit if the page is not the first page
      if (state.isFirstPage) {
        emit(state.copyWith(isFirstPage: false));
      }
    }
  }

  /// Called when a page is tapped down
  /// Hides the story widget if it's visible
  void onPageTappedDown() {
    // if the story widget is visible, scroll away
    if (state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: false);
    }
  }

  /// Called when scrolling up
  /// Hides the story widget if it's visible
  void onScrollUp() {
    if (state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: false);
    }
  }

  /// Called when scrolling down
  /// Shows the story widget if on first page and not visible
  void onScrollDown() {
    if (state.isFirstPage && !state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: true);
    }
  }

  /// Animates the story widget's visibility
  /// [makeVisible] determines whether to show or hide the widget
  void _animateStoryWidget({required bool makeVisible}) {
    scrollController.animateTo(
      makeVisible ? -storyWidgetHeight : storyWidgetHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    emit(state.copyWith(isStoryWidgetVisible: makeVisible));
  }

  @override
  Future<void> close() {
    pageController.removeListener(_onPageChange);
    pageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
