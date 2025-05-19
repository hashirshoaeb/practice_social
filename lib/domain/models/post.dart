class PostModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String music;

  final String likeCount;
  final String commentCount;
  final String shareCount;

  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.music,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });
}
