
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:rasedapp_ye/login/login_page.dart';
import 'package:rasedapp_ye/widgets/circle_button.dart';
import 'package:rasedapp_ye/widgets/setting_item.dart';
import 'package:rasedapp_ye/widgets/textfield_widget.dart';

import '../splah_page.dart';
import '../utils/app_themes.dart';
import '../utils/app_widgets.dart';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  File? file;
  GlobalKey? formKey;
  bool? isLogin;

  @override
  void initState() {
    super.initState();

    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isLogin = GetStorage().read('profile') != null;
        if(isLogin!) {
          nameController = TextEditingController(text:GetStorage().read('profile')['user_name']??GetStorage().read('profile')['user_id'].toString());
        } else {
          nameController = TextEditingController(text:"");
        }
  }

  changeProfile(){
    if(isLogin!) {
      AppWidgets().MyDialog2(
                  context: context,
                  title: "account".tr(),
                  body: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'nameInput'.tr(),
                            style: Theme.of(context).textTheme.titleLarge,),
                          textFieldWidget(
                            hint: "nameInput".tr(),
                            controller: nameController!),
                          const SizedBox(height: 20,),
                                                    Text(
                            'image'.tr(),
                            style: Theme.of(context).textTheme.titleLarge,),
                          StatefulBuilder(builder: (context,setState){
                            return Column(
                              children: [
                                file == null?
                                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleButton(
                          iconSize: 30,
                          onPressed: () async {
                            XFile? xFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            file = File(xFile!.path);

                            if (file == null) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please select the image")));
                            }

                            setState(() {});
                          },
                          icon: Icons.storage_outlined),
                      CircleButton(
                          iconSize: 30,
                          onPressed: () async {
                            XFile? xFile = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            file = File(xFile!.path);
                            // Navigator.pop(context);
                            if (file == null) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please select the image")));
                            }
                            setState(() {});
                          },
                          icon: Icons.camera_outlined),
                    ],
                  )
                : CircleButton(
                    iconSize: 30,
                    onPressed: () {
                      file = null;
                      setState(() {});
                    },
                    icon: Icons.cancel),
                              ],
                            );
                          }),
                          const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: (){},
                              icon: const Icon(Icons.save_outlined,color: Colors.white,),
                               label: Text(
                                'save'.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                            const SizedBox(width: 20,),                    
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                              icon: const Icon(Icons.cancel_outlined,color: Colors.white,),
                               label: Text(
                                'cancel'.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          ],
                        )
                        ],
                      ),
                    ),
                  )
                );
    } else{
                   Get.offAll(() => const LoginPage());
                }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Headline6("profile".tr(),
            style: const TextStyle(
                color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const Margin.all(16),
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: Get.width / 4,
              height: Get.width / 4,
            ),
          ),
          ListTile(
            // leading: ProfileAvatar(imageUrl: URLs.imageFolder + (GetStorage().read('profile')['image_url']??"")),
            title: isLogin! ? Headline5(
              GetStorage().read('profile')['user_name']??GetStorage().read('profile')['user_id'].toString(),// "${GetStorage().read('profile')['user_name']??GetStorage().read('profile')['user_id'].toString()}",//"${FirebaseAuth.instance.currentUser!.phoneNumber}",
              textAlign: TextAlign.center,
            ):Headline5(
              'login'.tr(),//"${FirebaseAuth.instance.currentUser!.phoneNumber}",
              textAlign: TextAlign.center,
            ),
            subtitle: isLogin! ? Text(
              GetStorage().read('profile')['phone'],
              textAlign: TextAlign.center,
            ):const SizedBox.shrink(),
            onTap: changeProfile,
          ),
          const Divider(),
          ListTile(
            title: Headline6(
              "settings".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          profileItem(
              icon: Ionicons.globe_outline,
              title: "language".tr(),
              subtitle: translator.activeLanguageCode,
              iconBackground: const Color(0xff3DB2FF),
              onTap: () {
                translator.setNewLanguage(
                  context,
                  newLanguage:
                  translator.activeLanguageCode == 'ar' ? 'en' : 'ar',
                  remember: true,
                );
              }),
          profileItem(
              icon: GetStorage().read("darkMode")
                  ? Ionicons.moon
                  : Ionicons.sunny,
              title: "theme".tr(),
              subtitle:
              GetStorage().read("darkMode") ? "dark".tr() : "light".tr(),
              iconBackground: const Color(0xffFC5404),
              onTap: () {
                if (GetStorage().read("darkMode")) {
                  setState(() {
                    Get.changeThemeMode(ThemeMode.light);
                    GetStorage().write("darkMode", false);
                  });
                } else {
                  setState(() {
                    Get.changeThemeMode(ThemeMode.dark);
                    GetStorage().write("darkMode", true);
                  });
                }
              }),
            isLogin! ? profileItem(
              icon: Icons.manage_accounts_outlined,
              title: "account".tr(),
              subtitle: "",
              iconBackground: Colors.blueAccent,
              onTap: changeProfile) : const SizedBox.shrink(),
          isLogin! ?profileItem(
              icon: Ionicons.log_out_outline,
              title: "logout".tr(),
              subtitle: "logoutDescription".tr(),
              iconBackground: const Color(0xffDF2E2E),
              onTap: () {
                AppWidgets().MyDialog(
                    context: context,
                    asset: const Icon(
                      Ionicons.information_circle,
                      size: 80,
                      color: Colors.white,
                    ),
                    background: const Color(0xff3DB2FF),
                    title: "logout".tr(),
                    subtitle: "logoutConfirm".tr(),
                    confirm: ElevatedButton(
                        onPressed: () async {
                          // await FirebaseMessaging.instance
                          //     .unsubscribeFromTopic("user");
                          // await FirebaseMessaging.instance.unsubscribeFromTopic(
                          //     FirebaseAuth.instance.currentUser!.uid);
                          //
                          // await FirebaseAuth.instance
                          //     .signOut()
                          //     .then((value) => Get.offAll(() => SplashPage()));
                          GetStorage().remove('isLogin');
                          GetStorage().remove('profile');
                          Get.offAll(() => const SplashPage());
                        },
                        child: Text("yes".tr())),
                    cancel: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: Get.theme.elevatedButtonTheme.style!.copyWith(
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xffDF2E2E))),
                        child: Text("no".tr())));
              }):const SizedBox.shrink(),
              !isLogin! ? profileItem(
              icon: Icons.login_outlined,
              title: "login".tr(),
              subtitle: "",
              iconBackground: Colors.teal,
              onTap: changeProfile) : const SizedBox.shrink(),
          ListTile(
            title: Headline6(
              "aboutApp".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          profileItem(
              icon: Ionicons.information,
              title: "appName".tr(),
              subtitle: "version".tr(),
              iconBackground: const Color(0xff3DB2FF)),
          profileItem(
              icon: Ionicons.shield_half,
              title: "privacyPolicy".tr(),
              subtitle: "privacyPolicyDescription".tr(),
              iconBackground: const Color(0xffDF2E2E),
              onTap: () async {
                // if (!await launchUrl(Uri.parse(AppConst.privacyPolicyLink)))
                //   throw 'Could not launch';
              }),
        ],
      ),
    );
  }
}
