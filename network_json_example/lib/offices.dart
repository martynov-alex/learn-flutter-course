import 'dart:convert';
import 'package:http/http.dart' as http;

class OfficesList {
  OfficesList({required this.offices});
  List<Office> offices;

  factory OfficesList.fromJson(Map<String, dynamic> json) {
    var officesJson = json['offices'] as List;
    List<Office> officesList =
        officesJson.map((office) => Office.fromJson(office)).toList();

    return OfficesList(
      offices: officesList,
    );
  }
}

class Office {
  const Office(
      {required this.name, required this.address, required this.image});
  final String name;
  final String address;
  final String image;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      name: json['name'] as String,
      address: json['address'] as String,
      image: json['image'] as String,
    );
  }
}

Future<OfficesList> getOfficesList() async {
  const url = 'https://about.google/static/data/locations.json';
  Uri uri = Uri.parse(url);
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
