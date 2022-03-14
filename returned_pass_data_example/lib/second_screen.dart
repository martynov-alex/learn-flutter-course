import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: textEditingController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String textToSendback = textEditingController.text;
                Navigator.pop(context, textToSendback);
              },
              child: Text('Send text back'),
            ),
          ],
        ),
      ),
    );
  }
}
