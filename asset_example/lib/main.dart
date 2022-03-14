// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IndieFlower'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adding Assets'),
        ),
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage('assets/images/bg.jpg'),
              ),
              Image.asset('assets/icons/icon.png'),
              Positioned(
                top: 16,
                left: 115,
                child: Text(
                  'My custom font',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    //fontFamily: 'IndieFlower',
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
