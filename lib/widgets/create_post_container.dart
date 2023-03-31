import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ionicons/ionicons.dart';
import 'package:rasedapp_ye/main.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
import 'package:rasedapp_ye/widgets/setting_item.dart';

import '../models/user_model.dart';
import 'profile_avatar.dart';

class CreatePostContainer extends StatelessWidget {
  // final User currentUser;

  const CreatePostContainer({
    Key? key,
    // required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white10,
        child: profileItem(

          icon: Ionicons.share_outline,
          subtitle: "شارك اي حدث مناخي, لمساعدة الأخرين في الابتعاد",
          title: "انت الراصد",
          iconBackground: AppThemes.primaryColor,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(selectedIndex: 2,),)),
        )
        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         ProfileAvatar(imageUrl: currentUser.imageUrl),
        //         const SizedBox(width: 8.0),
        //         Expanded(
        //           child: TextField(
        //             decoration: InputDecoration.collapsed(
        //               hintText: 'انت الراصد؟',
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //     const Divider(height: 10.0, thickness: 0.5),
        //     Container(
        //       height: 40.0,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           ElevatedButton.icon(
        //             onPressed: () => print('Video'),
        //             icon: const Icon(
        //               Icons.videocam,
        //               color: Colors.red,
        //             ),
        //             label: Text('فيديو'),
        //           ),
        //           const VerticalDivider(width: 8.0),
        //           ElevatedButton.icon(
        //             onPressed: () => print('Photo'),
        //             icon: const Icon(
        //               Icons.photo_library,
        //               color: Colors.green,
        //             ),
        //             label: Text('صورة'),
        //           ),
        //           // const VerticalDivider(width: 8.0),
        //           // ElevatedButton.icon(
        //           //   onPressed: () => print('Room'),
        //           //   icon: const Icon(
        //           //     Icons.video_call,
        //           //     color: Colors.purpleAccent,
        //           //   ),
        //           //   label: Text('Room'),
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
