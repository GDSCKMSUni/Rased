import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/main.dart';
import 'package:rasedapp_ye/utils/app_themes.dart';
import 'package:rasedapp_ye/utils/app_widgets.dart';
import 'package:rasedapp_ye/utils/urls.dart';

import '../models/city.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<City> cities =
      []; //City.citiesList.where((city) => city.isDefault == false).toList();
  List<City> selectedCities = [];
  int selectedCityId = 0;
  List<City> getSelectedCities() {
    List<City> selectedCities = cities;
    return selectedCities.where((city) => city.isSelected == true).toList();
  }

  bool isConnect = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () {
      isConnect = false;
      setState(() {});
    }).runtimeType;
    fetchAllCities();
    selectedCities = getSelectedCities();
  }

  fetchAllCities() async {
    var response = await getRequest(URLs.getCity);
    for (int i = 0; i < response['data'].length; i++) {
      cities.add(City(
          isSelected: false,
          cityId: response['data'][i]['city_id'],
          city: response['data'][i]['city_name'].toString(),
          country: response['data'][i]['country'],
          isDefault: false));
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
        title: Text(
          '${selectedCities.length} selected',
          style: AppThemes.darkTextTheme().titleLarge,
        ),
      ),
      body: (cities.isNotEmpty)
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .08,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: cities[index].isSelected == true
                          ? Border.all(
                              color: AppThemes.primaryColor.withOpacity(.6),
                              width: 2,
                            )
                          : Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: AppThemes.primaryColor.withOpacity(.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              cities[index].isSelected =
                                  !cities[index].isSelected!;
                              selectedCities = getSelectedCities();
                            });
                          },
                          child: Image.asset(
                            cities[index].isSelected == true
                                ? 'assets/images/checked.png'
                                : 'assets/images/unchecked.png',
                            width: 30,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        cities[index].city,
                        style: TextStyle(
                          fontSize: 16,
                          color: cities[index].isSelected == true
                              ? AppThemes.primaryColor
                              : Colors.black54,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : (isConnect)
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Connection Failed...",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppThemes.mainColor,
        child: const Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
        onPressed: () {
          if (selectedCities.isEmpty) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please select at least one city"),
              duration: Duration(seconds: 3),
            ));
          } else {
            AppWidgets().MyDialog2(
                title: "Defualt City",
                subtitle: "Please select one defualt city",
                context: context,
                body: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectedCities.length,
                    itemBuilder: (context, i) {
                      return RadioListTile(
                          value: selectedCities[i].cityId,
                          title: Text(
                            selectedCities[i].city,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          groupValue: selectedCityId,
                          onChanged: (val) async {
                            var citiesId = "";
                            for (var c in selectedCities) {
                              citiesId += "${c.cityId}&";
                            }
                            citiesId =
                                citiesId.substring(0, citiesId.length - 1);
                            Navigator.pop(context);
                            
                            var response =
                                await postRequest(URLs.sendUserCities, {
                              'cities': citiesId,
                              'user_id': GetStorage()
                                  .read('profile')['user_id']
                                  .toString(),
                              'city_id': val.toString()
                            });

                            if (response['result'] == 'done') {
                              GetStorage().write('isLogin', true);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                  (route) => false);
                            } else {
                              AppWidgets().MyDialog2(
                              title: "Connection Failed...",
                                  context: context,
                                  body: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 60,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ));
                            }
                          });
                    }));
          }
        },
      ),
    );
  }
}
