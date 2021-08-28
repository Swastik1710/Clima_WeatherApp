import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherLocationData});
  final weatherLocationData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temp;
  String name;
  String displayIcon;
  String displayText;
  String displayBackground;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherLocationData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        name = '';
        // displayIcon = 'null';
        displayText = 'Unable to get weather data';
        displayBackground = 'clearsky';
        return;
      }
      temp = weatherData['main']['temp'].toInt();
      int cond = weatherData['weather'][0]['id'];
      name = weatherData['name'];
      // displayIcon = weatherData['weather'][0]['icon'];
      // displayIcon = weather.getWeatherIcon(cond);
      displayText = weather.getMessage(temp);
      displayBackground = weather.getBackground(cond);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.blue,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background_$displayBackground.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.weatherLocation();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () async {
                        var typedValue = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if (typedValue != null) {
                          var weatherData =
                              await weather.getCityWeather(typedValue);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.search,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       // color: Colors.grey,
              //       // border: Border.all(width: 2),
              //       // borderRadius: BorderRadius.circular(100),
              //       ),
              //   child: Image(
              //     image: AssetImage('images/$displayIcon.png'),
              //     height: 100,
              //   ),
              // ),
              Text(
                '$temp°',
                style: kTempTextStyle,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      "$displayText in $name!",
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
