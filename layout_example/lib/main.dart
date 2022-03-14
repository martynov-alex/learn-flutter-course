// ignore_for_file: prefer_const_constructors
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffe5fce2),
        appBar: AppBar(
          title: Text('Weather', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Color(0xffe5fce2),
          systemOverlayStyle: SystemUiOverlayStyle(),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: [
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _weatherDescription(),
                Divider(),
                _temperature(),
                Divider(),
                _temperatureForecast(),
                Divider(),
                _footerRatings(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Image _headerImage() {
  return Image(
    image: NetworkImage(
        'https://www.meme-arsenal.com/memes/bfe7c73e59464cba3729d1f9bb348809.jpg'),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Tuesday - May 22',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
      Text(
        'Moscow Weather Forecast. Providing a local hourly Moscow weather forecast of rain, sun, wind, humidity and temperature.',
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
    ],
  );
}

Container _temperature() {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Colors.grey),
      ),
    ),
    child: Row(
      children: [
        Column(
          children: [
            Icon(Icons.sunny, color: Colors.yellow[900]),
          ],
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '15°C Clear',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [Text('Omskaya oblast, Omsk')],
            ),
          ],
        )
      ],
    ),
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(
      7,
      (int index) => Chip(
        backgroundColor: Colors.white,
        avatar: Icon(Icons.cloud, color: Colors.blue),
        label: Text(
          '${index + 20}°C',
          style: TextStyle(fontSize: 14),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(color: Colors.grey),
      ),
    ),
  );
}

Row _footerRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, size: 15, color: Colors.yellow[900]),
      Icon(Icons.star, size: 15, color: Colors.yellow[900]),
      Icon(Icons.star, size: 15, color: Colors.yellow[900]),
      Icon(Icons.star, size: 15, color: Colors.black),
      Icon(Icons.star, size: 15, color: Colors.black),
    ],
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        'Info with openweathermap.org',
        style: TextStyle(fontSize: 15),
      ),
      stars,
    ],
  );
}
