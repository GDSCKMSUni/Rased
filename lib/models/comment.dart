import 'package:rasedapp_ye/models/user_model.dart';

class Comment {
  String text;
  int commentId;
  String date;
  bool isSentByThis;
  User user;
  Comment(
      {required this.date,
      required this.commentId,
      required this.text,
      required this.isSentByThis,
      required this.user});
}