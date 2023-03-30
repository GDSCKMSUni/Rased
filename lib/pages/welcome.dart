import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/main.dart';
import 'package:rasedapp_ye/pages/get_started.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
import 'package:rasedapp_ye/utils/urls.dart';

import '../models/city.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
    List<City> cities = [];//City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = [];
  
  List<City> getSelectedCities(){
    List<City> selectedCities = cities;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
  @override
  void initState() {
    super.initState();
    fetchAllCities();
    selectedCities = getSelectedCities();
  }

    fetchAllCities()async{
      var response = await getRequest(URLs.getCity);
      for(int i=0;i<response['data'].length;i++){
        cities.add(City(isSelected: false, city: response['data'][i]['city_name'].toString(), country: response['data'][i]['country'], isDefault: false));
        }
        setState(() {});
    }
  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.mainColor,
        title: Text(selectedCities.length.toString() + ' selected',style: AppThemes.darkTextTheme().headline6,),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * .08,
            width: size.width,
            decoration: BoxDecoration(
                border: cities[index].isSelected == true ? Border.all(
                  color: AppThemes.primaryColor.withOpacity(.6),
                  width: 2,
                ) : Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppThemes.primaryColor.withOpacity(.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]
            ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: (){
                      setState(() {
                        cities[index].isSelected = !cities[index].isSelected;
                        selectedCities = getSelectedCities();
                      });
                    },
                    child: Image.asset(cities[index].isSelected == true ? 'assets/images/checked.png' : 'assets/images/unchecked.png', width: 30,)),
                const SizedBox( width: 10,),
                Text(cities[index].city, style: TextStyle(
                  fontSize: 16,
                  color: cities[index].isSelected == true ? AppThemes.primaryColor : Colors.black54,
                ),)
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemes.mainColor,
        child: const Icon(Icons.pin_drop,color: Colors.white,),
        onPressed: (){
          if(selectedCities.length == 0){
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please select at least one city"),duration: Duration(seconds: 3),)
            );
          }else{
            
            GetStorage().write('isLogin', true);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
          }
        },
      ),
    );
  }
}
