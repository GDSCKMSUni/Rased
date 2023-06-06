import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/pages/get_started.dart';
import 'package:rasedapp_ye/utils/urls.dart';

// import '../utils/app_helper.dart';
import '../utils/app_themes.dart';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class PincodePage extends StatefulWidget {
  final String phoneNumber;

  const PincodePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _PincodePageState createState() => _PincodePageState();
}

class _PincodePageState extends State<PincodePage> {
  String? _verificationCode;
  String verificationID = "";

  var response = {};
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
  }
  bool isSendLoading = true;
  bool checkPinLoading = false;

  // FirebaseAuth auth = FirebaseAuth.instance;

  _verifyPhone() async {
    
    Timer(const Duration(seconds: 15), () {
      isSendLoading = false;
      setState(() {
      });
     });

    await Future.delayed(const Duration(seconds: 2));
    response = await postRequest(URLs.signUp, {
      'phone':widget.phoneNumber
    });
    if(response['result']=='done'){
      // checkPinLoading = true;
      GetStorage().write('profile', response['data']);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const GetStarted())
      , (route) => false);
    }
    isSendLoading = false;
    
    setState(() {
      
    });
    // await auth.verifyPhoneNumber(
    //     phoneNumber: widget.phoneNumber,
    //     verificationCompleted: (PhoneAuthCredential credential) async {
    //       //await auth.signInWithCredential(credential);
    //       /* .then((value) async {
    //         if (value.user != null) {
    //           print(value.user!.phoneNumber);
    //         }
    //       });*/
    //     },
    //     verificationFailed: (FirebaseAuthException e) {
    //       print("-" * 50);
    //       print(e.message);
    //     },
    //     codeSent: (String verificationId, int? resendToken) async {
    //       print("code sent");
    //       setState(() {
    //         _verificationCode = verificationId;
    //         verificationID = verificationId;
    //         isSendLoading = false;
    //       });
    //     },
    //     codeAutoRetrievalTimeout: (String verificationID) {
    //       /* setState(() {
    //         //_verificationCode = verificationID;
    //       });*/
    //     },
    //     timeout: const Duration(minutes: 2));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Headline6("verification".tr(),
            style: const TextStyle(
                color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: isSendLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Headline5(
              "pleasWait".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Headline6(
              "pleasWaitDescription".tr(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: const LinearProgressIndicator(
                minHeight: 10,
              ),
            ),
          ],
        )
            : Center(
              child: (response['result']=='phone-error')?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,color: Colors.red,size: 60,),
                  const SizedBox(height: 20,),
                  Text(
                    "Sorry, the number you entered already exists",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  OutlinedButton(onPressed: (){}, child: const Text('Resend Code'))
                ],
              ):(response['result']=='done')?const SizedBox():Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,color: Colors.red,size: 60,),
                  const SizedBox(height: 20,),
                  Text(
                    "Connection Failed...",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center
                  )
                ],
              ),
            )
        //     Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Headline5(
        //       "pinCode".tr(),
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //       textAlign: TextAlign.center,
        //     ),
        //     Headline6(
        //       "${'enter6Digit'.tr()} ${widget.phoneNumber}",
        //       textAlign: TextAlign.center,
        //     ),
        //     const SizedBox(
        //       height: 32,
        //     ),
        //     Pinput(
        //       length: 6,
        //       focusNode: _pinPutFocusNode,
        //       controller: _pinPutController,
        //       pinAnimationType: PinAnimationType.fade,
        //       onCompleted: (pin) async {
        //         setState(() {
        //           checkPinLoading = true;
        //         });
        //         // PhoneAuthCredential credential =
        //         //     PhoneAuthProvider.credential(
        //         //         verificationId: verificationID, smsCode: pin);
        //         //
        //         // await auth.signInWithCredential(credential);

        //         try {
        //           // PhoneAuthCredential credential =
        //           // PhoneAuthProvider.credential(
        //           //     verificationId: verificationID, smsCode: pin);
        //           // await auth
        //           //     .signInWithCredential(credential)
        //           //     .then((value) async {
        //           //   print(value.user.toString());
        //           //   if (value.user != null) {
        //           //     await FirebaseMessaging.instance
        //           //         .subscribeToTopic("user");
        //           //     await FirebaseMessaging.instance
        //           //         .subscribeToTopic(auth.currentUser!.uid);

        //               // await AppData().checkUserExist(
        //               //     userUid: value.user!.uid,
        //               //     userPhone: "${value.user!.phoneNumber}");

        //               setState(() {
        //                 checkPinLoading = false;
        //               });
        //               AppWidgets().MyDialog(
        //                   context: context,
        //                   asset: const Icon(
        //                     Ionicons.checkmark_circle,
        //                     size: 80,
        //                     color: Colors.white,
        //                   ),
        //                   background: context.color.primary,
        //                   title: "loginSuccess".tr(),
        //                   confirm: ElevatedButton(
        //                       onPressed: () {
        //                         Get.offAll(() => const MainPage());
        //                       },
        //                       child: Text("ok".tr())));
        //           //   }
        //           // });
        //         }
        //         catch (e) {
        //           print("-" * 50);
        //           print("$e");
        //           FocusScope.of(context).unfocus();
        //           setState(() {
        //             checkPinLoading = false;
        //           });
        //           AppWidgets().MyDialog(
        //               context: context,
        //               asset: const Icon(
        //                 Ionicons.close_circle,
        //                 size: 80,
        //                 color: Colors.white,
        //               ),
        //               background: const Color(0xffDF2E2E),
        //               title: "invalidOtp".tr(),
        //               confirm: ElevatedButton(
        //                   onPressed: () {
        //                     Get.back();
        //                   },
        //                   child: Text("back".tr())));
        //         }
        //       },
        //     ),
        //     checkPinLoading
        //         ? const SizedBox(
        //       height: 32,
        //     )
        //         : const SizedBox(),
        //     checkPinLoading
        //         ? ClipRRect(
        //       borderRadius: BorderRadius.circular(32),
        //       child: const LinearProgressIndicator(
        //         minHeight: 10,
        //       ),
        //     )
        //         : const SizedBox(),
        //   ],
        // ),
      ),
    );
  }
}
