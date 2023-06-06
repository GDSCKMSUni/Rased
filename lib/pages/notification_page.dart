import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../utils/app_themes.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "notification".tr(),
          style: const TextStyle(
              color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          child:const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Ionicons.notifications_off_outline, size: 100,),),
              Text("You Not have Notification", textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}
