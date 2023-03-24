import 'package:flutter/material.dart';
import 'package:rasedapp_ye/widgets/textfield_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/main.dart';
class YouRased extends StatelessWidget {
  const YouRased({super.key});

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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const textFieldWidget(hint: 'الاسم',),
            const textFieldWidget(hint: 'التاريخ'),
            const textFieldWidget(hint: 'العنوان الرئيسي'),
            const textFieldWidget(hint: 'رقم الهاتف (اختياري)'),
            const textFieldWidget(
              hint: 'تفاصيل اكثر',
              maxlines: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.video_call_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
              ],
            )
          ],
        ),
      
      ),
    );
  }
}
