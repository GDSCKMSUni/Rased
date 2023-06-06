import 'package:flutter/material.dart';


import '../widgets/home_widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
