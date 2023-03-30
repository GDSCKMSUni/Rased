import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
import 'package:path/path.dart';
import 'package:rasedapp_ye/utils/urls.dart';
import 'dart:convert';

import '../widgets/textfield_widget.dart';

class RasedPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  RasedPage({Key? key}) : super(key: key);
  File? file;
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
      body: ListView(

        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textFieldWidget(hint: 'nameInput'.tr(),controller: nameController,),
          textFieldWidget(hint: "dateInput".tr(),controller: dateController),
          textFieldWidget(hint: "addressInput".tr(),controller: addressController),
          textFieldWidget(hint: "phoneInput".tr(),controller: phoneController),
          textFieldWidget(
            hint: "detailsInput".tr(),
            maxlines: 5,controller: detailsController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () async{
                 XFile? xFile = await ImagePicker().pickImage(source:ImageSource.gallery);
                file = File(xFile!.path);
                Navigator.pop(context);
                if(file == null){
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select the image")));
                }

                var response = await postRequestWithFile(URLs.sendPost,
                {
                    "title": "Tilte1",
                    "content": "",
                    "id":GetStorage().read('profile')['user_id']
                },file!);
              }, icon: Icon(Icons.storage_outlined,size: 30,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.camera_outlined,size: 30)),
              // IconButton(
              //     onPressed: () {}, icon: Icon(Icons.video_call_rounded)),
              // IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
            ],
          )
        ],
      ),
      floatingActionButton: 
      FloatingActionButton(onPressed: (){},
      backgroundColor: AppThemes.primaryColor,
      
      child: Icon(Icons.upload)),
    );
  }
}
