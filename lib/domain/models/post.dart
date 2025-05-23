/// Represents a social media post in the application
/// This model contains all the necessary data for displaying and interacting with a post
class PostModel {
  /// Unique identifier for the post
  final String id;

  /// Title of the post or username of the poster
  final String title;

  /// Main content/description of the post
  final String content;

  /// URL of the post's main image
  final String imageUrl;

  /// Name of the music track associated with the post
  final String music;

  /// Number of likes on the post
  final String likeCount;

  /// Number of comments on the post
  final String commentCount;

  /// Number of times the post has been shared
  final String shareCount;

  /// Creates a new PostModel instance
  ///
  /// All parameters are required to ensure complete post data
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
