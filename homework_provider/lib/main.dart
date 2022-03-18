import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SwitchProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Provider homework'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SwitchProvider _state = Provider.of<SwitchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: _randomColor1())),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: _randomSide(),
              height: _randomSide(),
              color: _randomColor2(),
              alignment: Alignment.center,
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              //child: const FlutterLogo(size: 75),
            ),
            Switch(
              value: _state._switchState,
              onChanged: (bool newValue) =>
                  context.read<SwitchProvider>().moveSwitch(),
            ),
          ],
        ),
      ),
    );
  }
}

Color _randomColor1() => Color.fromARGB(
      255,
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
    );

Color _randomColor2() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];

double _randomSide() => Random().nextInt(200) + 50;

class SwitchProvider extends ChangeNotifier {
  bool _switchState = true;

  void moveSwitch() {
    _switchState = !_switchState;
    notifyListeners();
  }
}
