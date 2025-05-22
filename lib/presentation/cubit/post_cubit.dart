import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/domain/models/post.dart';
import 'package:practice_social/domain/post_repository.dart';

sealed class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;

  PostLoaded({required this.posts});
}

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;

  PostCubit({required this.postRepository}) : super(PostInitial());

  void getPosts() async {
    emit(PostLoading());
    final posts = await postRepository.getPosts();
    emit(PostLoaded(posts: posts));
  }
}
