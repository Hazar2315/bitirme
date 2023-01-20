import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:hazar_emlak/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RealEstatesService {
  String url = "http://localhost:8060/api/realEstates";
  final RealEstates realEstates = RealEstates();

  Future<RealEstates> UpdateRealEstates(RealEstates realEstates) async {
    final updateUrl = Uri.parse("$url/put");
    var response = await http.put(updateUrl,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(realEstates.toJson()));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return RealEstates.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future<List<RealEstates>> getPost() async {
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    //var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(decodeData);
      List<RealEstates> realEstates =
          data.map((dynamic item) => RealEstates.fromJson(item)).toList();
      return realEstates;
    } else {
      throw "cant get post";
    }
  }

  Future<void> deleteReal(int id) async {
    Response response = await delete(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      print("deleted");
    }
  }
}
