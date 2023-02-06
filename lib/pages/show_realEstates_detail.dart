import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:hazar_emlak/models/rating.dart';
import 'package:hazar_emlak/services/ratingService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/models/real_estates_img.dart';
import 'package:hazar_emlak/services/real_estates_image_service.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';
import 'package:hazar_emlak/widgets/myCustomRow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowDetail extends StatefulWidget {
  ShowDetail({
    Key? key,
    required this.realEstate,
  }) : super(key: key);
  final RealEstates realEstate;
  @override
  State<ShowDetail> createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  Ratings rating = Ratings();
  List<Ratings>? ratingsList;
  bool isLoading = false;
  bool commentLoading = false;
  var img;
  RealEstatesImageService realEstatesImageService = RealEstatesImageService();
  String url = "http://localhost:8060/api/rating/uploadComment";

  Future saveComment() async {
    var user_id = GetStorage().read("user_id");
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': user_id,
          'realEstates_id': widget.realEstate.id,
          'comments': rating.comment,
          'ratings': rating.ratings
        }));
    // print(rest.body);
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    final RealEstatesIMG response =
        await realEstatesImageService.getPost(widget.realEstate.id!);
    print(response.base64!);
    print(response.base64.runtimeType);
    img = base64Decode(response.base64!);
    setState(() {
      isLoading = false;
    });
  }

  getComment() async {
    setState(() {
      commentLoading = true;
    });
    final List<Ratings> response =
        await RatingService().getPost(widget.realEstate.id!);
    print(response.toString());
    ratingsList = response;
    setState(() {
      commentLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    final commentField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: rating.comment),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        rating.comment = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ' Yorum Alanı Boş';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade300)),
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            saveComment().then((value) => getComment());
          },
        ),
        prefixIcon: Icon(Icons.view_headline_sharp),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Yorumunuz/Sorularınız",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        title: Text(
          widget.realEstate.id.toString(),
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.lightGreen.shade400),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.lightGreen.shade50, Colors.white]),
          ),
        ),
      ),
      body: isLoading
          ? Text("true")
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.white, Colors.lightGreen.shade400])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(flex: 10, child: Image.memory(img)),
                  Expanded(
                    flex: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            MyRow(
                                baslik: "Adres : ",
                                deger: widget.realEstate.headerText!),
                            Divider(),
                            MyRow(
                                baslik: "Açıklama ve Açık adres : ",
                                deger: widget.realEstate.bodyText!),
                            Divider(),
                            MyRow(
                                baslik: "Gayrimenkul Türü : ",
                                deger: widget.realEstate.realEstateType!),
                            Divider(),
                            MyRow(
                                baslik: "Kiralık/Satılık : ",
                                deger: widget.realEstate.rentSale!),
                            Divider(),
                            MyRow(
                                baslik: "Fiyat : ",
                                deger: widget.realEstate.price!.toString()),
                            Divider(),
                            MyRow(
                                baslik: "Metrekare/Dönüm : ",
                                deger:
                                    widget.realEstate.squareMeters!.toString()),
                            Divider(),
                            MyRow(
                                baslik: "Oda Sayısı : ",
                                deger: widget.realEstate.roomNumbers!),
                            Divider(),
                            MyRow(
                                baslik: "Emlakçı : ",
                                deger: widget.realEstate.sellersCompany!),
                            Divider(),
                            MyRow(
                                baslik: "Emlakçı Telefon Numarası : ",
                                deger: widget.realEstate.sellerPhone!),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ratingsList == null
                      ? Text("no comments")
                      : Expanded(
                          flex: 20,
                          child: ListView.builder(
                            itemCount: ratingsList!.length,
                            itemBuilder: (contex, index) => Card(
                              shadowColor: Colors.black26,
                              elevation: 8,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              child: ListTile(
                                title: Text(
                                  ratingsList![index].comment!,
                                ),
                                leading: Icon(Icons.comment_sharp),
                                subtitle: Text("Kullanıcı Rol : " +
                                    ratingsList![index].user!.role +
                                    " Kullanıcı:" +
                                    ratingsList![index].user!.email +
                                    " Gayrimenkul no : " +
                                    ratingsList![index]
                                        .realEstates!
                                        .id
                                        .toString() +
                                    " Gayrimenkul Puanı : " +
                                    ratingsList![index].ratings.toString() +
                                    "/5"),
                                iconColor: Colors.green.shade400,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Gayrimenkulü Puanlayınız : "),
                      RatingBar(
                        minRating: 1,
                        maxRating: 5,
                        initialRating: 3,
                        allowHalfRating: true,
                        onRatingUpdate: (ratings) {
                          if (ratings == 0) {
                            setState(() {
                              ratings = 5;
                              rating.ratings = rating.ratings! + ratings;
                            });
                          } else {
                            setState(() {
                              rating.ratings = ratings;
                            });
                          }
                        },
                        ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: Colors.lightGreen.shade400,
                            ),
                            half: const Icon(
                              Icons.star_half_outlined,
                              color: Colors.lightGreen,
                            ),
                            empty: Icon(
                              Icons.star_border_outlined,
                              color: Colors.grey,
                            )),
                        updateOnDrag: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  commentField,
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }
}
