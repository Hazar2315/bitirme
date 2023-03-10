import 'dart:convert';
import 'dart:developer';
import 'package:hazar_emlak/pages/real_estates_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/services/real_estates_service.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';

import '../models/rating.dart';
import '../models/real_estates_img.dart';
import '../services/ratingService.dart';
import '../services/real_estates_image_service.dart';

class RealEstatesDetail extends StatefulWidget {
  RealEstates realEstates;

  RealEstatesDetail({
    Key? key,
    required this.realEstates,
  }) : super(key: key);

  @override
  _RealEstatesDetailState createState() => _RealEstatesDetailState();
}

class _RealEstatesDetailState extends State<RealEstatesDetail> {
  bool commentLoading = false;
  Ratings rating = Ratings();
  List<Ratings>? ratingsList;
  RealEstatesImageService realEstatesImageService = RealEstatesImageService();
  bool isLoading = false;
  var img;
  final RealEstatesService realEstatesService = RealEstatesService();

  getData() async {
    setState(() {
      isLoading = true;
    });

    final RealEstatesIMG response =
        await realEstatesImageService.getPost(widget.realEstates.id!);
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
        await RatingService().getPost(widget.realEstates.id!);
    print(response.toString());
    ratingsList = response;
    setState(() {
      commentLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen.shade400,
          title: Text(widget.realEstates.headerText.toString()),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete_sharp),
          focusColor: Colors.lightGreen.shade400,
          onPressed: () async {
            //await realEstatesImageService.deleteImg(widget.realEstates.id!);
            await realEstatesService.deleteReal(widget.realEstates.id!);

            RealEstateViewModel.singleton.getData();
            Navigator.of(context).pop();
          },
        ),
        drawer: NavigationDrawerWidget(),
        body: isLoading
            ? Text("true")
            : Center(
                child: Column(
                  children: [
                    Expanded(
                        flex: 8,
                        child: SizedBox(height: 250, child: Image.memory(img))),
                    SizedBox(height: 15),
                    Expanded(
                      flex: 10,
                      child: ListView(children: [
                        Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text("Gayrimenkul A????klamas??"),
                                subtitle: Text(
                                    widget.realEstates.bodyText.toString()),
                              ),
                              ListTile(
                                title: Text("Kiral??k M?? Sat??l??k"),
                                subtitle: Text(
                                    widget.realEstates.rentSale.toString()),
                              ),
                              ListTile(
                                title: Text("Gayrimenkul ya????"),
                                subtitle: Text(
                                    widget.realEstates.buildAge.toString()),
                              ),
                              ListTile(
                                title: Text("Fiyat??"),
                                subtitle:
                                    Text(widget.realEstates.price.toString()),
                              ),
                              ListTile(
                                title: Text("Ka?? m2"),
                                subtitle: Text(
                                    widget.realEstates.squareMeters.toString()),
                              ),
                              ListTile(
                                title: Text("Oda Say??s??"),
                                subtitle: Text(
                                    widget.realEstates.roomNumbers.toString()),
                              ),
                              ListTile(
                                title: Text("Emlak???? ??smi"),
                                subtitle: Text(widget.realEstates.sellersCompany
                                    .toString()),
                              ),
                              ListTile(
                                title: Text("Emlak???? Telefon Numaras??"),
                                subtitle: Text(
                                    widget.realEstates.sellerPhone.toString()),
                              ),
                              ListTile(
                                title: Text("Gayrimenkul t??r??"),
                                subtitle: Text(widget.realEstates.realEstateType
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ratingsList == null
                        ? Text("no comments")
                        : Expanded(
                            flex: 7,
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
                                  subtitle: Text("Kullan??c??:" +
                                      ratingsList![index].user!.email +
                                      " Gayrimenkul no : " +
                                      ratingsList![index]
                                          .realEstates!
                                          .id
                                          .toString() +
                                      " Gayrimenkul Puan?? : " +
                                      ratingsList![index].ratings.toString() +
                                      "/5"),
                                  iconColor: Colors.green.shade400,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ));
  }
}
