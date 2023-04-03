import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
getRequest(String url) async{
  try{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      return responsebody;
    }else{
      print('Error ${response.statusCode}');
      return null;
    }
  }catch(e){
    print('Error catch $e');
      return null;
  }
}
postRequest(String url,Map data) async{
  try{
    var response = await http.post(Uri.parse(url),body:data);
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      return responsebody;
    }else{
      print('Error ${response.statusCode}');
      return null;
    }
  }catch(e){
    print('Error catch $e');
      return null;
  }
}
Future postRequestWithoutBody(String url) async{
  try{
    var response = await http.post(Uri.parse(url));
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      return responsebody;
    }else{
      print('Error ${response.statusCode}');
      return null;
    }
  }catch(e){
    print('Error catch $e');
      return null;
  }
}
requestPeremision()async{
  var status = await Permission.camera.status;
  if(!status.isGranted){
    await Permission.camera.request();
  }

  var status1 = await Permission.storage.status;
  if(!status1.isGranted){
    await Permission.storage.request();
  }


  var status2 = await Permission.location.status;
  if(!status2.isGranted){
    await Permission.location.request();
  }
}
 postRequestWithFile(String url,Map data,File file) async{
  var request = http.MultipartRequest("POST",Uri.parse(url));


  var length =await file.length();
  var stream = http.ByteStream(file.openRead());

  var multiPartFile = http.MultipartFile("image",stream,length,
  filename:basename(file.path));
  request.files.add(multiPartFile);

  data.forEach((key,value){
    request.fields[key] = value;
  });
  var myRequest = await request.send();

  var response = await http.Response.fromStream(myRequest);
  if(myRequest.statusCode == 200){
    print(response.body);
    return jsonDecode(response.body);
  }
  else {
    print("Error ${myRequest.statusCode}");
  }
}

Future getCurrentLocation() async{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(serviceEnabled){
    return await Geolocator.getCurrentPosition();
;
  }
  return null;
  // LocationPermission permission = await Geolocator.checkPermission();
  // if(permission == LocationPermission.denied){
  //   permission = await Geolocator.requestPermission();
  //   if(permission == LocationPermission.denied){
  //     return null;
  //   }
  // }
  // if(permission == LocationPermission.deniedForever){
  //   return null;
  // }

}


