import 'package:flutter/material.dart';
import '../../domain/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
            title: Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.favorite_border),
                const SizedBox(width: 8),
                Text('${post.likes} likes'),
                const Spacer(),
                const Icon(Icons.comment_outlined),
                const SizedBox(width: 8),
                Text('${post.comments} comentarios'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(post.description),
          ),
        ],
      ),
    );
  }
}
