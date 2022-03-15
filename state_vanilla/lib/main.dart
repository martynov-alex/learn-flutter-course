import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vanilla state'),
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
  int _rating = 1;

  void _setRating(int newRating) {
    setState(() {
      _rating = newRating;
      print(_rating);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarWidget(
                  positionRating: 1,
                  currentRating: _rating,
                  callBack: _setRating,
                ),
                StarWidget(
                  positionRating: 2,
                  currentRating: _rating,
                  callBack: _setRating,
                ),
                StarWidget(
                  positionRating: 3,
                  currentRating: _rating,
                  callBack: _setRating,
                ),
                StarWidget(
                  positionRating: 4,
                  currentRating: _rating,
                  callBack: _setRating,
                ),
                StarWidget(
                  positionRating: 5,
                  currentRating: _rating,
                  callBack: _setRating,
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return StarWidget(
                      positionRating: (index + 1),
                      currentRating: _rating,
                      callBack: _setRating,
                    );
                  }),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StarWidget extends StatelessWidget {
  const StarWidget(
      {Key? key,
      required this.positionRating,
      required this.currentRating,
      required this.callBack})
      : super(key: key);

  final int currentRating;
  final int positionRating;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(
        currentRating >= positionRating ? Icons.star : Icons.star_border,
        color: Colors.green,
      ),
      onPressed: () {
        callBack(positionRating);
      },
    );
  }
}
