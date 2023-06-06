import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/login/login_page.dart';
import 'package:rasedapp_ye/models/comment.dart';
import 'package:rasedapp_ye/models/post_model.dart';
import 'package:rasedapp_ye/models/user_model.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
// import 'package:rasedapp_ye/data/data.dart';
import 'package:rasedapp_ye/utils/urls.dart';
import 'package:rasedapp_ye/widgets/circle_button.dart';

class CommentsBottomSheet extends StatefulWidget {
  final Function(int) onCommentSend;
  final Post post;
  const CommentsBottomSheet({
    required this.onCommentSend,
    required this.post,
    Key? key
    }) : super(key: key);

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  List<Comment> comments = [];
  late FocusNode commentFocusController;
  late TextEditingController textCommentController;

fetchAllPostComments()async{
  var response = await postRequest(URLs.getComments, {
    'id': widget.post.postId.toString()
  });
  if(response != null){
    for(int i=0;i<response['data'].length;i++){
      bool isSendByThis = false;
      if(GetStorage().read('profile')!=null){
        isSendByThis = response['data'][i]["user_id"]==GetStorage().read('profile')['user_id'];
      }
      comments.add(
        Comment(date: response['data'][i]["date"],
        commentId:response['data'][i]["comment_id"],
        text:response['data'][i]["comment_title"],
        isSentByThis: isSendByThis,
        user: User(
          id: response['data'][i]["user_id"],
          name: response['data'][i]["user_name"]
        )));
    }
  }
  setState(() {});
}

  @override
  void initState() {
    commentFocusController = FocusNode();
    textCommentController = TextEditingController();
fetchAllPostComments();
    super.initState();
  }
  @override
  dispose() {
    super.dispose();
    commentFocusController.dispose();
  }
  

  addComment() async{
    if(textCommentController.text == '')
     {
       commentFocusController.requestFocus();
     }
    else{
      if(GetStorage().read('profile')!=null){
              var response = await postRequest(URLs.addComment, {
            'date' : "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
            'user_id' : GetStorage().read('profile')['user_id'].toString(),
            'post_id' : widget.post.postId.toString(),
            'title' : textCommentController.text
          });
          comments.add(Comment(date: "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}",
          commentId: 0, text: textCommentController.text, isSentByThis: true,
          user: User(id: GetStorage().read('profile')['user_id'], name: GetStorage().read('profile')['user_name']??GetStorage().read('profile')['user_id'].toString())));
          textCommentController.text = "";
          widget.onCommentSend(widget.post.postIndex);
          setState(() {});
      }
      else{
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Row(
            children: [
              const Text("Please Login to Rased App"),
              TextButton(onPressed: ()=>Get.offAll(()=>const LoginPage()), child: Text('login'.tr(),style: const TextStyle(color:Colors.blue),)),
            ],
          )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return makeDismissible(context,
      child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 1,
          minChildSize:  0.4,
          builder:(_,controller)=>Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15),
              child: Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextBoxComment(
                    textMessageController: textCommentController,
                    addComment: addComment,
                    messageFocusController: commentFocusController),
              ),
                            SendButton(
                  addComment:()=> addComment(),),
            ],
          ),
          // #grouped listview:
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return false;
              },
              child: GroupedListView<Comment, String>(
                controller: controller,
                floatingHeader: true,
                elements: comments,
                groupBy: (comment) => comment.date,
                groupHeaderBuilder: (Comment comment) => SizedBox(
                  // height: 40,
                  child: Center(
                    child: Card(
                      color: AppThemes.primaryColor,
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            comment.date,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
                itemBuilder: (context, Comment comment) => Align(
                  alignment: comment.isSentByThis
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Card(
                    elevation: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 20, top: 5),
                          child: Text(
                            comment.user.name,
                            style: TextStyle(
                                color: AppThemes.primaryColor.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 2),
                          child: Text(comment.text),
                        ),
                      ],
                    ),
                  ),
                ),
                // MessageBubble(message:message),
              ),
            ),
          ),
        ],
      ),
    ),
          ), ),
    );
  }
}


Widget makeDismissible(BuildContext context,{required Widget child} )=>GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap:()=>Navigator.of(context).pop() ,
  child: GestureDetector(
    onTap: (){},child: child,
  ),
);


class TextBoxComment extends StatelessWidget {
  TextEditingController textMessageController;
  Function() addComment;
  final messageFocusController;
  TextBoxComment(
      {Key? key,
      required this.addComment,
      required this.textMessageController,
      required this.messageFocusController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: AppThemes.primaryColor, width: 2, style: BorderStyle.solid)),
      height: 50,
      padding: const EdgeInsets.all(10),
      child: TextField(
        focusNode: messageFocusController,
        controller: textMessageController,
        // textAlign: TextAlign.right,
        onSubmitted: (text) {
          addComment();
        },
        cursorRadius: const Radius.circular(10),
        cursorWidth: 2,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Text(
            'enterComment'.tr(),
          ),
          labelStyle: const TextStyle(
            color: Color(0xff5b5b5b),
            fontSize: 17,
            // fontWeight: FontWeight.w500,
          ),
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  Function()? addComment;
  SendButton(
      {Key? key, required this.addComment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleButton(
        iconSize: 30,
          icon: AppThemes().goIcon,
          onPressed: addComment
             ),
    );
  }
}




