import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_themes.dart';
import '../widgets/weather_item.dart';

class DetailPage extends StatefulWidget {
  final List consolidatedWeatherList;
  final int selectedId;
  final String location;
  final String city ;

  const DetailPage(
      {Key? key,
        required this.consolidatedWeatherList,
        required this.selectedId,
        required this.city,
        required this.location,})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //Create a shader linear gradient
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    int selectedIndex = widget.selectedId;
    // var weatherStateName = "Ahmed";
    // widget.consolidatedWeatherList[selectedIndex]['weather_state_name'];
    // imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();

    return Scaffold(
      backgroundColor: AppThemes.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppThemes.lightGreyColor,
        elevation: 0.0,
        title: Text(widget.location),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  // Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => const Welcome()));
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: 150,
              width: 400,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.consolidatedWeatherList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // var futureWeatherName = widget
                    //     .consolidatedWeatherList[index]['weather_state_name'];
                    // var weatherURL =
                    // futureWeatherName.replaceAll(' ', '').toLowerCase();
                    var parsedDate = DateTime.parse(widget
                        .consolidatedWeatherList[index]['date']);
                    var newDate =
                    DateFormat('EEEE').format(parsedDate).substring(0, 3);

                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.only(right: 20),
                      width: 80,
                      decoration: BoxDecoration(
                          color: index == selectedIndex
                              ? Colors.white
                              : const Color(0xff9ebcf9),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 5,
                              color: Colors.blue.withOpacity(.3),
                            )
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.consolidatedWeatherList[index]['day']['avgtemp_c']}C",
                            style: TextStyle(
                              fontSize: 17,
                              color: index == selectedIndex
                                  ? Colors.blue
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Image.network(
                          //   'http:'+ widget.consolidatedWeatherList[index]['day']['condition']['icon'] ,
                          //   loadingBuilder: (context,widget,image){
                          //     return CircularProgressIndicator();
                          //   },
                          // ),
                          CachedNetworkImage(
                              // placeholder: (context,val){
                              //   return CircularProgressIndicator();
                              // },
                              imageUrl:
                          /*'assets/images/' +*/'http:'+ widget.consolidatedWeatherList[index]['day']['condition']['icon'] /*+ '.png'*/,
                          width: 40,
                        ),
                          Text(
                            newDate,
                            style: TextStyle(
                              fontSize: 17,
                              color: index == selectedIndex
                                  ? Colors.blue
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      width: size.width * .7,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 25),
                              blurRadius: 3,
                              spreadRadius: -10,
                            ),
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Positioned(
                          //   top: -40,
                          //   left: 20,
                          //   child: Image.network(
                          //     // 'assets/images/' + imageUrl + '.png',
                          //     // 'http:'+ imageUrl,
                          //     width: 150,
                          //   ),
                          // ),
                          Positioned(
                              top: 120,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  widget.city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  weatherItem(
                                    text: 'Wind Speed',
                                    value: widget
                                        .consolidatedWeatherList[selectedIndex]
                                    ['day']['maxwind_kph'],
                                    unit: 'km/h',
                                    imageUrl: 'assets/images/windspeed.png',
                                  ),
                                  weatherItem(
                                      text: 'Humidity',
                                      value: widget.consolidatedWeatherList[
                                      selectedIndex]['day']['avghumidity'],
                                      unit: '',
                                      imageUrl: 'assets/images/humidity.png'),
                                  weatherItem(
                                    text: 'Max Temp',
                                    value: widget
                                        .consolidatedWeatherList[selectedIndex]
                                    ['day']['maxtemp_c'],
                                    unit: 'C',
                                    imageUrl: 'assets/images/max-temp.png',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.consolidatedWeatherList[selectedIndex]
                                  ['day']['avgtemp_c']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 300,
                      left: 20,
                      child: SizedBox(
                        height: 200,
                        width: size.width * .9,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount:
                            widget.consolidatedWeatherList.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              // var futureWeatherName =
                              // widget.consolidatedWeatherList[index]
                              // ['weather_state_name'];
                              // var futureImageURL = futureWeatherName
                              //     .replaceAll(' ', '')
                              //     .toLowerCase();
                              var myDate = DateTime.parse(
                                  widget.consolidatedWeatherList[index]
                                  ['date']);
                              var currentDate =
                              DateFormat('d MMMM, EEEE')
                                  .format(myDate);
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    right: 10,
                                    bottom: 5),
                                height: 80,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppThemes
                                            .lightGreyColor
                                            .withOpacity(.1),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentDate,
                                        style: const TextStyle(
                                          color: Color(0xff6696f5),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget
                                                .consolidatedWeatherList[
                                            index]['day']['maxtemp_c']
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 30,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                          const Text(
                                            '/',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 30,
                                            ),
                                          ),
                                          Text(
                                            widget
                                                .consolidatedWeatherList[
                                            index]['day']['mintemp_c']
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //   MainAxisAlignment.center,
                                      //   children: [
                                      //     Image.asset(
                                      //       'assets/images/' +
                                      //           futureImageURL +
                                      //           '.png',
                                      //       width: 30,
                                      //     ),
                                      //     Text(widget.consolidatedWeatherList[
                                      //     index]
                                      //     ['weather_state_name']),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
