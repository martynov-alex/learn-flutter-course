import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking'),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}

Future<http.Response> getData() async {
  const url = 'https://about.google/static/data/locations.json';
  Uri uri = Uri.parse(url);
  return await http.get(uri);
}

void loadData() {
  getData().then((response) {
    if (response.statusCode == 200) {
      debugPrint(response.body);
    } else {
      debugPrint('Status code: ${response.statusCode}');
    }
  }).catchError((error) {
    debugPrint(error.toString());
  });
}
