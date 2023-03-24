import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../data/data.dart';
import '../models/post_model.dart';
import '../utils/app_themes.dart';
import '../widgets/circle_button.dart';
import '../widgets/create_post_container.dart';
import '../widgets/post_container.dart';
import '../widgets/rooms.dart';
import '../widgets/stories.dart';

class CommunityPage extends StatelessWidget {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  // @override
  // void dispose() {
  //   _trackingScrollController.dispose();
  //   super.dispose();
  // }
  CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: InkWell(
        //     onTap: () {},
        //     child: Icon(Ionicons.search_outline),
        //   ),
        //   title: Text(
        //     "community".tr(),
        //     style: const TextStyle(
        //         color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: _HomeScreenMobile(),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController? scrollController;

  const _HomeScreenMobile({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'المجتمع',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          floating: true, systemOverlayStyle: SystemUiOverlayStyle.dark,
          // actions: [
          //   CircleButton(
          //     icon: Icons.search,
          //     iconSize: 30.0,
          //     onPressed: () => print('Search'),
          //   ),
          //   CircleButton(
          //     icon: Icons.send,
          //     iconSize: 30.0,
          //     onPressed: () => print('Messenger'),
          //   ),
          // ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Rooms(onlineUsers: onlineUsers),
        //   ),
        // ),
        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Stories(
        //       currentUser: currentUser,
        //       stories: stories,
        //     ),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(post: post);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}
