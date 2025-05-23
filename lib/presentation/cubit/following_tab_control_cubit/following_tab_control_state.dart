/// State class for FollowingTabControl
/// Manages the visibility of story widget and current page position
class FollowingTabControlState {
  /// Whether the story widget is currently visible
  final bool isStoryWidgetVisible;

  /// Whether the user is on the first page of PageView
  final bool isFirstPage;

  /// Creates a new FollowingTabControlState
  const FollowingTabControlState({
    this.isStoryWidgetVisible = false,
    this.isFirstPage = true,
  });

  /// Creates a copy of this state with the given fields replaced with new values
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
