import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/domain/models/post.dart';
import 'package:practice_social/domain/post_repository.dart';

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

/// Cubit responsible for managing post data
/// Handles fetching and updating posts
class PostCubit extends Cubit<PostState> {
  /// Repository for fetching post data
  final PostRepository postRepository;

  /// Creates a new PostCubit with the given repository
  PostCubit({required this.postRepository}) : super(PostInitial());

  /// Fetches posts from the repository
  /// Emits loading state while fetching and loaded state when complete
  void getPosts() async {
    emit(PostLoading());
    final posts = await postRepository.getPosts();
    emit(PostLoaded(posts: posts));
  }
}
