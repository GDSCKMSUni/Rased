import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
getRequest(String url) async{
  try{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      return responsebody;
    }else{
      print('Error ${response.statusCode}');
    }
  }catch(e){
    print('Error catch $e');
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
    }
  }catch(e){
    print('Error catch $e');
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

 postRequestWithFile(String url,Map data,File file) async{
  var request = http.MultipartRequest("POST",Uri.parse(url));


  var length =await file.length();
  var stream = http.ByteStream(file.openRead());

  var multiPartFile = http.MultipartFile("file",stream,length,
  filename:basename(file.path));
  request.files.add(multiPartFile);

  data.forEach((key,value){
    request.fields[key] = value;
  });
  var myRequest = await request.send();

  var response = await http.Response.fromStream(myRequest);
  if(myRequest.statusCode == 200){
    return jsonDecode(response.body);
  }
  else {
    print("Error ${myRequest.statusCode}");
  }
}
