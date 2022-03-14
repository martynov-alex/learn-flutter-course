// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text('Weather Forecast'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            _textFieldContainer(height: 70),
            _cityDetailContainer(height: 100),
            SizedBox(height: 20),
            _temperatureDetailContainer(height: 120),
            SizedBox(height: 20),
            _extraWeatherDetailContainer(height: 100),
            SizedBox(height: 20),
            _bottomDetailSizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}

Container _textFieldContainer({required double height}) {
  return Container(
    height: height,
    padding: EdgeInsets.all(10),
    child: TextField(
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: 'Enter City Name',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
      ),
      onChanged: (value) {},
    ),
  );
}

Container _cityDetailContainer({required double height}) {
  return Container(
    height: height,
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          child: Text(
            'Omsk, Omskaya oblast, Russia',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Text(
          'Friday, Mar 20, 2020',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}

Container _temperatureDetailContainer({required double height}) {
  return Container(
    height: height,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.sunny, size: 80),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '14 °C',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              'LIGHT SNOW',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ],
    ),
  );
}

Container _extraWeatherDetailContainer({required double height}) {
  return Container(
    height: height,
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.ac_unit, size: 30),
            Text('6', style: TextStyle(fontSize: 25)),
            Text('km/hr', style: TextStyle(fontSize: 15)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.ac_unit, size: 30),
            Text('3', style: TextStyle(fontSize: 25)),
            Text('%', style: TextStyle(fontSize: 15)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.ac_unit, size: 30),
            Text('20', style: TextStyle(fontSize: 25)),
            Text('%', style: TextStyle(fontSize: 15)),
          ],
        ),
      ],
    ),
  );
}

Column _bottomDetailSizedBox({required double height}) {
  List<ListItem> forecastData = ForecastData().forecastData;
  return Column(
    children: [
      Text(
        '7-DAY WEATHER FORECAST',
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        height: height,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          scrollDirection: Axis.horizontal,
          itemCount: forecastData.length,
          itemBuilder: (context, int index) {
            final item = forecastData[index];
            if (item is DayForecastItem) {
              return Container(
                margin: EdgeInsets.only(left: 8),
                padding: EdgeInsets.all(8),
                width: 150,
                color: Colors.red[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(item.day, style: TextStyle(fontSize: 25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${item.temp.toStringAsFixed(0)} °C',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(width: 5),
                        Icon(item.icon, size: 40),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    ],
  );
}

abstract class ListItem {}

class DayForecastItem implements ListItem {
  const DayForecastItem(this._day, this._temp, this._icon);
  final String _day;
  final double _temp;
  final IconData _icon;

  String get day => _day;
  double get temp => _temp;
  IconData get icon => _icon;

  @override
  String toString() {
    return '$temp';
  }
}

class ForecastData {
  final List<ListItem> _forecastData = [
    DayForecastItem('Friday', 7.2, Icons.wb_cloudy),
    DayForecastItem('Saturday', 6.1, Icons.wb_sunny),
    DayForecastItem('Sunday', 9.2, Icons.wb_cloudy),
    DayForecastItem('Monday', 10.0, Icons.wb_cloudy),
    DayForecastItem('Tuesday', 4.2, Icons.wb_sunny),
    DayForecastItem('Wednesday', 8.2, Icons.wb_cloudy),
    DayForecastItem('Thursday', 6.7, Icons.wb_cloudy),
  ];

  List<ListItem> get forecastData => _forecastData;
}
