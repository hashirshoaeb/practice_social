import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingTabControlState {
  final bool isStoryWidgetVisible;
  final bool isFirstPage;

  const FollowingTabControlState({
    this.isStoryWidgetVisible = false,
    this.isFirstPage = true,
  });

  FollowingTabControlState copyWith({
    bool? isStoryWidgetVisible,
    bool? isFirstPage,
  }) {
    return FollowingTabControlState(
      isStoryWidgetVisible: isStoryWidgetVisible ?? this.isStoryWidgetVisible,
      isFirstPage: isFirstPage ?? this.isFirstPage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FollowingTabControlState &&
        other.isStoryWidgetVisible == isStoryWidgetVisible &&
        other.isFirstPage == isFirstPage;
  }

  @override
  int get hashCode => isStoryWidgetVisible.hashCode ^ isFirstPage.hashCode;

  @override
  String toString() {
    return 'FollowingTabControlState(isStoryWidgetVisible: $isStoryWidgetVisible, isFirstPage: $isFirstPage)';
  }
}

class FollowingTabControlCubit extends Cubit<FollowingTabControlState> {
  late final ScrollController scrollController;
  late final PageController pageController;

  double get storyWidgetHeight => 228;

  FollowingTabControlCubit() : super(FollowingTabControlState()) {
    scrollController = ScrollController(initialScrollOffset: storyWidgetHeight);
    pageController = PageController();
    pageController.addListener(_onPageChange);
  }

  void onViewStoryTapped() {
    if (!state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: true);
    }
  }

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

  // Or on tap down
  void onPageTappedDown() {
    // if the story widget is visible, scroll away
    if (state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: false);
    }
  }

  void onScrollUp() {
    if (state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: false);
    }
  }

  void onScrollDown() {
    if (state.isFirstPage && !state.isStoryWidgetVisible) {
      _animateStoryWidget(makeVisible: true);
    }
  }

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
