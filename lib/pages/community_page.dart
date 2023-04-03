import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/models/user_model.dart';
import 'package:rasedapp_ye/pages/get_started.dart';
import 'package:rasedapp_ye/utils/urls.dart';

import '../models/post_model.dart';
import '../utils/app_themes.dart';
import '../widgets/circle_button.dart';
import '../widgets/create_post_container.dart';
import '../widgets/post_container.dart';
import '../widgets/rooms.dart';
import '../widgets/stories.dart';

class CommunityPage extends StatelessWidget {
  // final TrackingScrollController _trackingScrollController =
  //     TrackingScrollController();

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
        body: HomeScreenMobile(),
      ),
    );
  }
}

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  List<Post> posts = [];
  // final TrackingScrollController? scrollController;

  fetchAllPosts()async{
    var response;
    if(GetStorage().read('profile')!=null){
         response = await postRequest(URLs.getPosts,{
      'id':GetStorage().read('profile')['user_id'].toString()
    });
    }
    else{
         response = await postRequestWithoutBody(URLs.getPosts);
    }

    if(response !=null){
      for (var i = 0; i < response['data'].length; i++) {
        posts.add(
          Post(
            comments: response['data'][i]['comments'],
            likes: response['data'][i]['likes'],
            postId: response['data'][i]['post_id'],
            caption: response['data'][i]['details'],
            lat: response['data'][i]['lat'],
            long: response['data'][i]['long'],
            imageUrl: URLs.imageFolder + response['data'][i]['image_url'],
            shares: 20,
            timeAgo: response['data'][i]['date'].toString().substring(0,15),
            user: User(name:response['data'][i]['user_name'],id: response['data'][i]['user_id']),
            userIsLike: response['data'][i]['is_like'] == 0?false:true,
            postIndex: i
            ),
          );
      }
    }
    setState(() {});
  }

  changeLikesCount(i,isLike)async{
    if(isLike){
      posts[i].likes++;
      var response = await postRequest(URLs.like, {
      'user_id':GetStorage().read('profile')['user_id'].toString(),
      'post_id':posts[i].postId.toString(),
      'type' : 'insert'
    });
    }else{
      posts[i].likes--;
      var response = await postRequest(URLs.like, {
      'user_id':GetStorage().read('profile')['user_id'].toString(),
      'post_id':posts[i].postId.toString(),
      'type' : 'delete'
    });
    }
  }
    changeCommentsCount(i){
      posts[i].comments++;
      setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
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
          floating: true,
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
          child: CreatePostContainer(/*currentUser: currentUser*/),
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
        
        posts.length == 0 ? 
        SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4,),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ):
         SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(post: post,onLikePress:changeLikesCount,onCommentSend:changeCommentsCount);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}
