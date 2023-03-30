import 'package:get_storage/get_storage.dart';
import 'package:rasedapp_ye/pages/get_started.dart';
import 'package:rasedapp_ye/pages/get_started.dart';

import '../main.dart';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // FirebaseAuth auth = FirebaseAuth.instance;

  goToLogin() {
    if (GetStorage().read('isLogin')) {
      Future.delayed(Duration(seconds: 5), () => Get.offAll(() => MainPage()));
    } else if(GetStorage().read('profile') !=null){
      Future.delayed(Duration(seconds: 5), () => Get.offAll(() => GetStarted()));
    }else {
      Future.delayed(Duration(seconds: 5), () => Get.offAll(() => LoginPage()));
    }
  }

  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // Headline3(
              //   "companyName".tr().replaceAll(" ", "\n"),
              //   textAlign: TextAlign.center,
              //   style:
              //       TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              // ),
              SizedBox(height:50,),

              Image.asset("assets/images/logo.png", width: 150, height: 150,),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                Text("جميع الحقوق محفوظة لدى Rased",textDirection: TextDirection.rtl,),

              ],)


            ],

          ),
        ),
      ),
    );
  }
}
