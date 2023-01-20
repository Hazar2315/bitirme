import 'package:hazar_emlak/models/real_estates_img.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class RealEstatesImageService {
  final RealEstatesIMG realEstatesIMG = RealEstatesIMG();

  Future<RealEstatesIMG> getPost(int id) async {
    String url = "http://localhost:8060/api/realEstates/getImage/$id";
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    //var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      // List<dynamic> data = jsonDecode(decodeData);
      // List<RealEstatesIMG> realEstatesImg =
      //     data.map((dynamic item) => RealEstatesIMG.fromJson(item)).toList();
      var decodeData = utf8.decode(response.bodyBytes);
      return RealEstatesIMG.fromJson(jsonDecode(decodeData));
    } else {
      print(response.statusCode);
      print(response.body);
      throw "error";
    }
  }

  Future<void> deleteImg(int id) async {
    Response response = await delete(
        Uri.parse("http://localhost:8060/api/realEstates/deleteImg/$id"));
    if (response.statusCode == 200) {
      print("deleted");
    }
  }
}
