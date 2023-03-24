import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'profile_avatar.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0.0),

      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(imageUrl: currentUser.imageUrl),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'انت الراصد؟',
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => print('Video'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: Text('فيديو'),
                  ),
                  const VerticalDivider(width: 8.0),
                  ElevatedButton.icon(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: Text('صورة'),
                  ),
                  // const VerticalDivider(width: 8.0),
                  // ElevatedButton.icon(
                  //   onPressed: () => print('Room'),
                  //   icon: const Icon(
                  //     Icons.video_call,
                  //     color: Colors.purpleAccent,
                  //   ),
                  //   label: Text('Room'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
