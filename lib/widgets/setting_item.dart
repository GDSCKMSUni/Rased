
 import 'package:flutter/material.dart';
import 'package:helpers/helpers/size.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
 
  Widget profileItem(
      {required IconData icon,
        required Color iconBackground,
        required String title,
        required String subtitle,
        Function()? onTap}) {
    return StatefulBuilder(builder: (context, _) {
      return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
          onTap: onTap,
          trailing: onTap != null
              ? Icon(translator.activeLanguageCode == 'ar'
              ? Ionicons.chevron_back
              : Ionicons.chevron_forward)
              : null,
          leading: Card(
            shape: RoundedRectangleBorder(borderRadius: EdgeRadius.all(10)),
            color: iconBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          title:
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            subtitle,
          ),
        ),
      );
    });
  }