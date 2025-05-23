import 'package:practice_social/domain/models/post.dart';

/// Base class for all post states
sealed class PostState {}

/// Initial state when no posts have been loaded
class PostInitial extends PostState {}

/// State when posts are being loaded
class PostLoading extends PostState {}

/// State when posts have been successfully loaded
class PostLoaded extends PostState {
  /// List of posts that have been loaded
  final List<PostModel> posts;

  /// Creates a new PostLoaded state with the given posts
  PostLoaded({required this.posts});
}
