import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SharedPrefereceExample(),
    );
  }
}

class SharedPrefereceExample extends StatefulWidget {
  @override
  _SharedPrefereceExampleState createState() => _SharedPrefereceExampleState();
}

class _SharedPrefereceExampleState extends State<SharedPrefereceExample> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const String kNumberPrefKey = 'Number preference';
  int _numberPref = 0;
  static const String kBoolPrefKey = 'Toggle preference';
  bool _boolPref = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _readNumberPref();
      _readBoolPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                Text('Number Preference'),
                Text('$_numberPref'),
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: () => _setNumberPref(_numberPref + 1),
                ),
              ]),
              TableRow(children: <Widget>[
                Text('Boolean Preference'),
                Text('$_boolPref'),
                ElevatedButton(
                  child: Text('Toogle'),
                  onPressed: () => _setBoolPref(!_boolPref),
                ),
              ]),
            ],
          ),
          ElevatedButton(
            child: Text('Reset Data'),
            onPressed: () => _resetDataPref(),
          ),
        ],
      ),
    );
  }

  Future<void> _setNumberPref(int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(kNumberPrefKey, value);
    _readNumberPref();
  }

  Future<void> _setBoolPref(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(kBoolPrefKey, value);
    _readBoolPref();
  }

  Future<void> _readNumberPref() async {
    final SharedPreferences prefs = await _prefs;
    final int value = prefs.getInt(kNumberPrefKey) ?? 0;
    setState(() {
      _numberPref = value;
    });
  }

  Future<void> _readBoolPref() async {
    final SharedPreferences prefs = await _prefs;
    final bool value = prefs.getBool(kBoolPrefKey) ?? false;
    setState(() {
      _boolPref = value;
    });
  }

  Future<void> _resetDataPref() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(kNumberPrefKey);
    await prefs.remove(kBoolPrefKey);
    _readNumberPref();
    _readBoolPref();
  }
}
