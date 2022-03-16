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
        title: const Text('Inherited Widget'),
      ),
      body: ListView(
        children: [
          MyInheritedWidget(
            child: const AppRootWidget(),
            myState: this,
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
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          const Text('(Root Widget)', style: kBigTextStyle),
          Text('${rootWidgetState?.counterValue}', style: kBigTextStyle),
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
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      margin: const EdgeInsets.all(4).copyWith(bottom: 32),
      color: Colors.yellowAccent,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            const Text('(Child Widget)'),
            Text('${rootWidgetState?.counterValue}', style: kBigTextStyle),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => rootWidgetState?._decrementCounter(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => rootWidgetState?._incrementCounter(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  // Создаем переменную, которя хранит состояние, которое нас интересует,
  // которое хотим изменить
  final _MyHomePageState myState;

  MyInheritedWidget({Key? key, required Widget child, required this.myState})
      : super(key: key, child: child);

  // Этот метод определяет нужно ли обновлять дочерние виджеты
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
