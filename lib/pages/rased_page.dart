import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/login/login_page.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
import 'package:rasedapp_ye/utils/app_widgets.dart';
import 'package:rasedapp_ye/utils/urls.dart';
import 'package:rasedapp_ye/widgets/circle_button.dart';

import '../widgets/textfield_widget.dart';

class RasedPage extends StatefulWidget {
  const RasedPage({super.key});

  @override
  State<RasedPage> createState() => _RasedPageState();
}

class _RasedPageState extends State<RasedPage> {
  late GlobalKey<FormState> formKey;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  File? file;

  @override
  void initState() {
    super.initState();
    requestPeremision();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF42C3A7),
        title: const Text(
          'أنت الراصد',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            textFieldWidget(
              hint: 'nameInput'.tr(),
              controller: nameController,
            ),
            // textFieldWidget(hint: "dateInput".tr(),controller: dateController),
            textFieldWidget(
                hint: "addressInput".tr(), controller: addressController),
            textFieldWidget(
              hint: "phoneInput".tr(),
              controller: phoneController,
              isOptional: true,
            ),
            textFieldWidget(
              hint: "detailsInput".tr(),
              maxlines: 5,
              controller: detailsController,
            ),
            (file == null)
                ? Row(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
          var locationValue = await getCurrentLocation();

             if(locationValue != null){
                if (formKey.currentState!.validate()) {
              if (file != null) {
                if(GetStorage().read('profile')!=null){
                var response = await postRequestWithFile(
                    URLs.sendPost,
                    {
                      'id': GetStorage().read('profile')['user_id'].toString(),
                      'name': nameController.text,
                      'address': addressController.text,
                      'date': DateTime.now().toString(),
                      'phone': phoneController.text,
                      'details': detailsController.text,
                      'lat': locationValue.latitude.toString(),
                      'long': locationValue.longitude.toString(),
                    },
                    file!);
                                    nameController.text = "";
                dateController.text = "";
                addressController.text = "";
                phoneController.text = "";
                detailsController.text = "";
                file = null;
                setState(() {});
                AppWidgets().MyDialog2(
                  context: context,
                  title: "Post Send Succesful",
                 body: const Icon(Icons.done_outline,size: 70,color: AppThemes.primaryColor,));
                }else{
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Row(
            children: [
              const Text("Please Login to Rased App"),
              TextButton(onPressed: ()=>Get.offAll(()=>const LoginPage()), child: Text('login'.tr(),style: const TextStyle(color:Colors.blue),))
            ],
          )));
                }
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select the image")));
              }
            }

              else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You Must Allow Rased App To Access To Location")));
              }
             }
            
          },
          backgroundColor: AppThemes.primaryColor,
          child: const Icon(Icons.upload)),
    );
  }
}
