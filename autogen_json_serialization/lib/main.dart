import 'package:autogen_json_serialization/offices.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON demo',
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
  late Future<OfficesList> officesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Переносим сюда потому что, если перенести в build, то будут при каждой
    // перересовке идти ненужные вызовы, данные меняются очень редко, это не погода
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autogen JSON serialization'),
      ),
      body: Center(
        child: FutureBuilder<OfficesList>(
          future: officesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.offices.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            '${snapshot.data?.offices[index].name ?? 'No data'}'),
                        subtitle: Text(
                            '${snapshot.data?.offices[index].address ?? 'No data'}'),
                        leading: Image.network(
                            '${snapshot.data?.offices[index].image ?? ''}'),
                        isThreeLine: true,
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
