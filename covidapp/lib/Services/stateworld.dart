import 'dart:convert';

import 'package:covidapp/Models/worldmodel.dart';
import 'package:covidapp/Services/appurl.dart';
import 'package:http/http.dart' as http;

class Worldstate {
  Future<WorldDetail> Getworlddata() async {
    final response = await http.get(Uri.parse(Appurl.worldstateapi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldDetail.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getcountrydata() async {
    var data;
    final response = await http.get(Uri.parse(Appurl.countrystateapi));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
