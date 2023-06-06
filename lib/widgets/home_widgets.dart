
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helpers/helpers.dart';
import 'package:intl/intl.dart';
import 'package:rasedapp_ye/functions.dart';
import 'package:rasedapp_ye/models/city.dart';
import 'package:rasedapp_ye/utils/urls.dart';

import '../pages/detail_page.dart';
import '../utils/app_themes.dart';
import 'weather_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //initiatilization
  double temperature = 0;
  double maxTemp = 0;
  String weatherStateName = 'Loading..';
  double humidity = 0;
  double windSpeed = 0;

  City selectedCity = City(city: "Sanaa",cityId: 0,country: "Yemen");

  var currentDate = 'Loading..';
  String imageUrl = '';
  double woeid =
  44418; //This is the Where on Earth Id for London which is our default city
  String location = 'Loading..'; //Our default city

  //get the cities and selected cities data
  // var selectedCities = City.getSelectedCities();
  List<City> cities = [
    // 'Yemen'
  ]; //the list to hold our selected cities. Deafult is London

  List consolidatedWeatherList = 
  [
  //   {
  //   'the_temp':15,
  //   'applicable_date':"2023-03-29",
  //   'weather_state_name':"Samet"
  // },
  // {
  //   'the_temp':17,
  //   'applicable_date':"2023-03-30",
  //   'weather_state_name':"Samet"
  // },
  // {
  //   'the_temp':12,
  //   'applicable_date':"2023-04-01",
  //   'weather_state_name':"Samet"
  // }
  ]; //To hold our weather data after api call
  //Api calls url

  String searchLocationUrl =
      'https://www.metraweather.com/api/location/search/?query='; //To get the woeid
  String searchWeatherUrl =
      'https://www.metraweather.com/api/location/'; //to get weather details using the woeid

  //Get the Where on earth id
  void fetchLocation(/*String location*/) async {
    // var searchResult = await http.get(Uri.parse(searchLocationUrl + location));
    // var result = json.decode(searchResult.body)[0];
    // setState(() {
    //   woeid = result['woeid'];
    // });
    var response;
    if(GetStorage().read('profile') != null){
      response = await postRequest(URLs.getCity, {
        'id' : GetStorage().read('profile')['user_id'].toString()
    });
    }else{
      response = await postRequestWithoutBody(URLs.getCity);
    }

    if(response != null){
    for(int i=0;i<response['data'].length;i++){
      cities.add(City(
        cityId: response['data'][i]['city_id'],
        city: response['data'][i]['city_name'],
        country: response['data'][i]['country']));
    }
    selectedCity = cities[0];
    location = cities[0].country;
    }
    // setState(() {});
  }

  void fetchWeatherData(String city) async {

    // var weatherResult =
    // await http.get(Uri.parse());
    // var result = json.decode(weatherResult.body);
    // var consolidatedWeather = result['consolidated_weather'];
      // consolidatedWeatherList.clear();
      // // var date = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 0)));
      // var consolidatedWeather = await postRequestWithoutBody("${URLs.weatherUrl}$city&days=7");
      //   if(consolidatedWeather !=null){
      //     for(int i=1;i<8;i++)
      //       {
      //         consolidatedWeatherList.add(consolidatedWeather['forecast']['forecastday'][i]); 
      //       }
      //   } 
        consolidatedWeatherList.clear();
var consolidatedWeather = await postRequestWithoutBody("${URLs.weatherUrl}$city&days=7");
if (consolidatedWeather != null) {
  for (int i = 0; i < consolidatedWeather['forecast']['forecastday'].length; i++) {
    consolidatedWeatherList.add(consolidatedWeather['forecast']['forecastday'][i]); 
  }
}

 
      // await Future.forEach([1,2,3,4,5,6,7], (element) async{
      // var date = DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: element)));
      // var consolidatedWeather = await postRequestWithoutBody(URLs.weatherUrl + city.toString() +"&dt="+ date.toString());

      //   consolidatedWeatherList.add(consolidatedWeather['forecast']['forecastday'][0]); 
      // });

    setState(()  {

      // The index 0 referes to the first entry which is the current day. The next day will be index 1, second day index 2 etc...
      temperature = consolidatedWeatherList[0]['day']['avgtemp_c'];
      weatherStateName = selectedCity.city;
      humidity = consolidatedWeatherList[0]['day']['avghumidity'];
      windSpeed = consolidatedWeatherList[0]['day']['maxwind_kph'];
      maxTemp = consolidatedWeatherList[0]['day']['maxtemp_c'];

      //date formatting
      var myDate = DateTime.parse(consolidatedWeatherList[0]['date']);
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);

      //set the image url
      imageUrl = consolidatedWeatherList[0]['day']['condition']['icon']
          .replaceAll(' ', '')
          .toLowerCase(); 
          //remove any spaces in the weather state name
      //and change to lowercase because that is how we have named our images.

      // consolidatedWeatherList = consolidatedWeather
      //     .toSet()
      //     .toList();
           //Remove any instances of dublicates from our
      //consolidated weather LIST
    });
  }

  @override
  void initState() {
    consolidatedWeatherList = [];
    fetchLocation();
    fetchWeatherData("London");

    //For all the selected cities from our City model, extract the city and add it to our original cities list
    // for (int i = 0; i < selectedCities.length; i++) {
    //   cities.add(selectedCities[i].city);
    // }
    super.initState();
  }

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the mdeia query
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
              //our location dropdown
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: selectedCity,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((City city) {
                          return DropdownMenuItem(
                              value: city, child: Text(city.country));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCity = newValue!;
                            // fetchLocation();
                            fetchWeatherData(selectedCity.city);
                            location = selectedCity.country;
                          });
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  currentDate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppThemes.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppThemes.primaryColor.withOpacity(.5),
                          offset: const Offset(0, 25),
                          blurRadius: 10,
                          spreadRadius: -12,
                        )
                      ]),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        left: 20,
                        child: imageUrl == ''
                            ? const Text('')
                            : CachedNetworkImage(
                              // placeholder: (context,val){
                              //   return CircularProgressIndicator();
                              // },
                              imageUrl:
                          /*'assets/images/' +*/'http:$imageUrl' /*+ '.png'*/,
                          // width: 150,
                          // height: 150,
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: Text(
                          weatherStateName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                temperature.toString(),
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()..shader = linearGradient,
                                ),
                              ),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      weatherItem(
                        text: 'Wind Speed',
                        value: windSpeed,
                        unit: 'km/h',
                        imageUrl: 'assets/images/windspeed.png',
                      ),
                      weatherItem(
                          text: 'Humidity',
                          value: humidity,
                          unit: '',
                          imageUrl: 'assets/images/humidity.png'),
                      weatherItem(
                        text: 'Wind Speed',
                        value: maxTemp,
                        unit: 'C',
                        imageUrl: 'assets/images/max-temp.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Next 7 Days',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppThemes.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: 
                  Row(children:consolidatedWeatherList.mapIndexed((index, e) {
                    String today = DateTime.now().toString().substring(0, 10);
                      var selectedDay =
                      consolidatedWeatherList[index]['date'];
                      // var futureWeatherName =
                      // consolidatedWeatherList[index]['weather_state_name'];
                      // var weatherUrl =
                      // futureWeatherName.replaceAll(' ', '').toLowerCase();
          
                      var parsedDate = DateTime.parse(
                          consolidatedWeatherList[index]['date']);
                      var newDate = DateFormat('EEEE')
                          .format(parsedDate)
                          .substring(0, 3); //formateed date
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidatedWeatherList, selectedId: index, location: location,city: selectedCity.city,)));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          margin: const EdgeInsets.only(
                              right: 20, bottom: 10, top: 10),
                          width: 80,
                          decoration: BoxDecoration(
                              color: selectedDay == today
                                  ? AppThemes.primaryColor
                                  : Colors.white,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 5,
                                  color: selectedDay == today
                                      ? AppThemes.primaryColor
                                      : Colors.black54.withOpacity(.2),
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${consolidatedWeatherList[index]['day']['avgtemp_c']
                                    .round()}C",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: selectedDay == today
                                      ? Colors.white
                                      : AppThemes.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Image.asset(
                              //   'assets/images/' + weatherUrl + '.png',
                              //   width: 30,
                              // ),
                              Text(
                                newDate,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: selectedDay == today
                                      ? Colors.white
                                      : AppThemes.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
          
                          ),
                        ),
                      );
                  }) ),
                ),
                // ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: consolidatedWeatherList.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       String today = DateTime.now().toString().substring(0, 10);
                //       var selectedDay =
                //       consolidatedWeatherList[index]['applicable_date'];
                //       var futureWeatherName =
                //       consolidatedWeatherList[index]['weather_state_name'];
                //       var weatherUrl =
                //       futureWeatherName.replaceAll(' ', '').toLowerCase();
          
                //       var parsedDate = DateTime.parse(
                //           consolidatedWeatherList[index]['applicable_date']);
                //       var newDate = DateFormat('EEEE')
                //           .format(parsedDate)
                //           .substring(0, 3); //formateed date
          
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidatedWeatherList, selectedId: index, location: location,)));
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(vertical: 20),
                //           margin: const EdgeInsets.only(
                //               right: 20, bottom: 10, top: 10),
                //           width: 80,
                //           decoration: BoxDecoration(
                //               color: selectedDay == today
                //                   ? AppThemes.primaryColor
                //                   : Colors.white,
                //               borderRadius:
                //               const BorderRadius.all(Radius.circular(10)),
                //               boxShadow: [
                //                 BoxShadow(
                //                   offset: const Offset(0, 1),
                //                   blurRadius: 5,
                //                   color: selectedDay == today
                //                       ? AppThemes.primaryColor
                //                       : Colors.black54.withOpacity(.2),
                //                 ),
                //               ]),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 consolidatedWeatherList[index]['the_temp']
                //                     .round()
                //                     .toString() +
                //                     "C",
                //                 style: TextStyle(
                //                   fontSize: 17,
                //                   color: selectedDay == today
                //                       ? Colors.white
                //                       : AppThemes.primaryColor,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //               Image.asset(
                //                 'assets/images/' + weatherUrl + '.png',
                //                 width: 30,
                //               ),
                //               Text(
                //                 newDate,
                //                 style: TextStyle(
                //                   fontSize: 17,
                //                   color: selectedDay == today
                //                       ? Colors.white
                //                       : AppThemes.primaryColor,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ],
          
                //           ),
                //         ),
                //       );
                //     },
                // ),
          
              ],
            ),
          ),
        ),

    );
  }
}
