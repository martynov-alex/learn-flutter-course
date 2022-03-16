import 'package:flutter/material.dart';

const kBigTextStyle = TextStyle(fontSize: 30);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
      ),
      body: ListView(
        children: [AppRootWidget()],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50),
          Text('(Root Widget)', style: kBigTextStyle),
          Text('0', style: kBigTextStyle),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Counter(),
              Counter(),
            ],
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4).copyWith(bottom: 32),
      color: Colors.yellowAccent,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            Text('(Child Widget)'),
            Text('0', style: kBigTextStyle),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: null,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
