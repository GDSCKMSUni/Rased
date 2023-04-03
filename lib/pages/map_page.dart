
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';

class MapPage extends StatefulWidget {
  double? lat;
  double? long;
  MapPage({Key? key,required this.lat,required this.long}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Headline6("map".tr(),
            style: TextStyle(
                color: AppThemes.lightGreyColor, fontWeight: FontWeight.bold)),
      ),
      body: GoogleMap(
        markers: <Marker>{
          Marker(position:LatLng(widget.lat!,widget.long!),icon: BitmapDescriptor.defaultMarker, markerId:MarkerId("1") ),
        },
        initialCameraPosition: CameraPosition(target: LatLng(widget.lat!,widget.long!)),
      )
    );
  }
}
