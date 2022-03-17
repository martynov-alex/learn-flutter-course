import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Widget'),
      ),
      body: ListView(
        children: [
          ScopedModel<MyModelState>(
            model: MyModelState(),
            child: AppRootWidget(),
          ),
        ],
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
    return ScopedModelDescendant<MyModelState>(
      // Эта переменная позволяет не перестраивать виджет при обновлении состояния
      rebuildOnChange: false,
      builder: (context, child, model) => Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            const Text('(Root Widget)', style: kBigTextStyle),
            Text('${model.counterValue}', style: kBigTextStyle),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Counter(),
                Counter(),
              ],
            ),
          ],
        ),
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
    return ScopedModelDescendant<MyModelState>(
      // Эта переменная позволяет не перестраивать виджет при обновлении состояния
      rebuildOnChange: true,
      builder: (context, child, model) => Card(
        margin: const EdgeInsets.all(4).copyWith(bottom: 32),
        color: Colors.yellowAccent,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            children: [
              const Text('(Child Widget)'),
              Text('${model.counterValue}', style: kBigTextStyle),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => model._decrementCounter(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => model._incrementCounter(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyModelState extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void _decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
