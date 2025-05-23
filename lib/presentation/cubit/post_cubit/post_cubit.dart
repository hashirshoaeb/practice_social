import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/domain/repository/post_repository.dart';
import 'package:practice_social/presentation/cubit/post_cubit/post_state.dart';

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
