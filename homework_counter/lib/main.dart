// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap \'-\' to decrement',
              style: TextStyle(color: Colors.white),
            ),
            FittedBox(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.indigo[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _counter--;
                          });
                        },
                        icon: Icon(Icons.remove)),
                    SizedBox(
                      width: 22,
                      child: Text(
                        '$_counter',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _counter++;
                          });
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
              ),
            ),
            Text(
              'Tap \'+\' to increment',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
