import 'dart:convert';
import 'package:hazar_emlak/models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserService {
  String url = "http://localhost:8060/api/users";

  Future<void> deletePost(int id) async {
    Response response = await delete(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      print("deleted");
    }
  }

  Future<List<Users2>> getPost() async {
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    //var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(decodeData);
      List<Users2> users =
          data.map((dynamic item) => Users2.fromJson(item)).toList();
      return users;
    } else {
      throw "cant get post";
    }
  }
}
