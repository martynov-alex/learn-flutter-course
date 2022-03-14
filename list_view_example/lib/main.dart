// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Building ListView'),
          centerTitle: true,
        ),
        body: BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  final List<ListItem> items = List<ListItem>.generate(
    10000,
    (index) => index % 6 == 0
        ? HeadingItem('Heading $index')
        : MessageItem('Sender $index', 'Message body $index'),
  );
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      if (item is HeadingItem) {
        return ListTile(
          title: Text(
            item.heading,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(item.sender),
          subtitle: Text(item.body),
          leading: Icon(
            Icons.insert_photo,
            color: Colors.red,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      }
      return Text('Error');
      // return Card(
      //   child: ListTile(
      //     title: Text('${items[index]}'),
      //     leading: Icon(Icons.stars, color: Colors.red),
      //     trailing: Icon(Icons.stars, color: Colors.green),
      //   ),
      // );
    },
  );
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  HeadingItem(this.heading);
  final String heading;
}

class MessageItem implements ListItem {
  MessageItem(this.sender, this.body);
  final String sender;
  final String body;
}
