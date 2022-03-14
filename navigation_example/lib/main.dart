import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: FirstHome(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => FirstHome());
          case '/second':
            User user = settings.arguments as User;
            return MaterialPageRoute(
                builder: (context) => SecondHome(user: user));
        }
        return null;
      },
    ));

class FirstHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Home'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            User user = User(name: 'Sasha', age: 41);
            Navigator.pushNamed(context, '/second', arguments: user);
          },
          child: Text('Go to Second Home'),
        ),
      ),
    );
  }
}

class SecondHome extends StatelessWidget {
  const SecondHome({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} - ${user.age}'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back to First Home'),
        ),
      ),
    );
  }
}

class User {
  User({required this.name, required this.age});
  final String name;
  final int age;
}
