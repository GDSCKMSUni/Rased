import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rasedapp_ye/pages/comments_bottom_sheet.dart';

import '../models/post_model.dart';
import 'profile_avatar.dart';

class PostContainer extends StatefulWidget {
  final Post post;
  final Function(int,bool) onLikePress;
  final Function(int) onCommentSend;
  const PostContainer({
    Key? key,
    required this.post,
    required this.onLikePress,
    required this.onCommentSend,
  }) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {


  onLikeTap()async{
    if(GetStorage().read('profile') != null){
    widget.post.userIsLike = !widget.post.userIsLike;
      await widget.onLikePress(widget.post.postIndex,widget.post.userIsLike);
      setState(() {});
    }else{
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Login to Rased App")));
    }
  }
  openCommentBottomSheet(){
    showModalBottomSheet(
      context: context, builder: (context) => CommentsBottomSheet(onCommentSend:widget.onCommentSend,post: widget.post,),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 0.0,
      ),
      elevation:  0.0,

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: widget.post),
                  const SizedBox(height: 4.0),
                  Text(widget.post.caption),
                  widget.post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            widget.post.imageUrl != null
                ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CachedNetworkImage(imageUrl: widget.post.imageUrl),
            )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: widget.post,onLikeTab: onLikeTap,onCommentTab: openCommentBottomSheet,),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
          imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;
  final void Function()? onLikeTab;
  final void Function()? onCommentTab;
  const _PostStats({
    Key? key,
    required this.post,
    required this.onLikeTab,
    required this.onCommentTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${post.comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${post.shares} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icons.thumb_up_outlined,
              isLiked: post.userIsLike,
              label: 'Like',
              onTap: onLikeTab,
            ),
            _PostButton(
              icon: Icons.comment_outlined,
              isLiked: post.userIsLike,
              label: 'Comment',
              onTap: onCommentTab,
            ),
            _PostButton(
              icon:Icons.share_outlined,
              isLiked: post.userIsLike,
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final bool isLiked;
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                icon,
                color:isLiked&&icon==Icons.thumb_up_outlined?Colors.blueAccent: Colors.grey[600],
                size: 25.0,
              ),
                const SizedBox(width: 4.0),
                Text(label,style:isLiked&&icon==Icons.thumb_up_outlined? TextStyle(color:Colors.blueAccent ):TextStyle(),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
