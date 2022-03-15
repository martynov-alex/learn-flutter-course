import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'offices.g.dart';

@JsonSerializable()
class OfficesList {
  OfficesList({required this.offices});
  List<Office> offices;

  factory OfficesList.fromJson(Map<String, dynamic> json) =>
      _$OfficesListFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesListToJson(this);
}

@JsonSerializable()
class Office {
  const Office(
      {required this.name, required this.address, required this.image});
  // Если у нас есть переменные, которые мы хотим называть по-другому в отличии
  // от JSON, мы должны прописать вот такую конструкцию:
  // @JsonKey(name: 'dt'); - имя поля в JSON
  // DateTime dayTime; - новое имя

  final String name;
  final String address;
  final String image;

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);
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
