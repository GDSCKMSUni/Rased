import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/app_themes.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../widgets/home_widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(onTap: (){},child: Icon(Ionicons.search_outline),),
      //   title: Text(
      //     "home".tr(),
      //     style: TextStyle(
      //         color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Home(),
    );
  }
}
