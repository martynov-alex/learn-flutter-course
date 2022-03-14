import 'package:flutter/material.dart';
import 'package:returned_pass_data_example/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String text = 'Some Text';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(text),
            ),
            ElevatedButton(
              child: Text('Go to second screen'),
              onPressed: () async {
                final result = await _returnDataFromSecondScreen(context);
                setState(() {
                  text = result;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> _returnDataFromSecondScreen(BuildContext context) async {
  Route route = MaterialPageRoute(builder: (context) => SecondScreen());
  final String result = await Navigator.push(context, route);
  return result;
}
