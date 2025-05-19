import 'package:practice_social/domain/models/post.dart';

class PostRepository {
  const PostRepository();

  final clientId = 'p9csx0w38r2uD1QfpGWX0oRnphkXnmaGbixMB11Bdyw';

  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return <PostModel>[
      PostModel(
        id: '1',
        title: 'Name and Last Name',
        content: 'Caption of the post with a link to the song',
        imageUrl:
            'https://fastly.picsum.photos/id/865/1080/1920.jpg?hmac=BgrT7TopuXREjmOEL4DjJBPR8KbEBzXllzURWxOt2iI',
        music: 'Dil se re - Arjun Kanungo',
        likeCount: '900 k',
        commentCount: '10 k',
        shareCount: '9 k',
      ),
      PostModel(
        id: '2',
        title: 'Post and Last Name',
        content: 'Caption of the post 3',
        imageUrl:
            'https://fastly.picsum.photos/id/371/1080/1920.jpg?hmac=X_ygvHxdNidY8c44b35m1TYBayHIeTVkEJQIW2gyoCQ',
        music: 'Song name - song artist',
        likeCount: '10 k',
        commentCount: '10 k',
        shareCount: '10 k',
      ),
      PostModel(
        id: '3',
        title: 'Name and Name',
        content: 'Caption of the post 4',
        imageUrl:
            'https://fastly.picsum.photos/id/366/1080/1920.jpg?hmac=upYrYKbgnImClC5UXNNmLRT3NTW5kbY4-RmPoAJmYDE',
        music: 'Song name - song artist',
        likeCount: '90 k',
        commentCount: '1 k',
        shareCount: '11 k',
      ),
      PostModel(
        id: '4',
        title: 'Name and Name',
        content: 'Caption of the post 5',
        imageUrl:
            'https://fastly.picsum.photos/id/400/1080/1920.jpg?hmac=TSO7LVmC7WMAcSpbn3nSc9xpNfGM9qaQMf9EJ72Gi3I',
        music: 'Song name - song artist',
        likeCount: '90 k',
        commentCount: '1 k',
        shareCount: '1 k',
      ),
    ];
  }
}
