import 'package:hazar_emlak/models/rating.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class RatingService {
  Future<List<Ratings>> getPost(int id) async {
    String url = "http://localhost:8060/api/rating/getCommentById/$id";
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    //var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      // List<RealEstatesIMG> realEstatesImg =
      //     data.map((dynamic item) => RealEstatesIMG.fromJson(item)).toList();

      List<dynamic> data = jsonDecode(decodeData);

      print(data.toString());
      List<Ratings> ratings =
          data.map((dynamic item) => Ratings.fromJson(item)).toList();

      return ratings;
      //return Ratings.fromJson(jsonDecode(decodeData));
    } else {
      print(response.statusCode);
      print(response.body);
      throw "error";
    }
  }

  Future<List<Ratings>> getAllPost() async {
    String url = "http://localhost:8060/api/rating/getComment";
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    //var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      // List<RealEstatesIMG> realEstatesImg =
      //     data.map((dynamic item) => RealEstatesIMG.fromJson(item)).toList();

      List<dynamic> data = jsonDecode(decodeData);

      print(data.toString());
      List<Ratings> ratings =
          data.map((dynamic item) => Ratings.fromJson(item)).toList();

      return ratings;
      //return Ratings.fromJson(jsonDecode(decodeData));
    } else {
      print(response.statusCode);
      print(response.body);
      throw "error";
    }
  }
}
