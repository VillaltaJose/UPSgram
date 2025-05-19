class PostModel {
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final String description;
  final int likes;
  final int comments;

  PostModel({
    required this.username,
    required this.avatarUrl,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.comments,
  });
}
