

import 'user_model.dart';

class Post {
  final int postIndex;
  final int postId;
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  int likes;
  int comments;
  final int shares;
  bool userIsLike;

  Post({
    required this.postId,
    required this.postIndex,
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.userIsLike,
  });
}
