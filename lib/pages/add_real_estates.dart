import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/models/real_estates_img.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';
import 'package:hazar_emlak/services/imagePickers.dart';
import 'package:http/http.dart' as http;

class AddRealEstates extends StatefulWidget {
  AddRealEstates({Key? key}) : super(key: key);

  @override
  State<AddRealEstates> createState() => _AddRealEstatesState();
}

class _AddRealEstatesState extends State<AddRealEstates> {
  final _formKey = GlobalKey<FormState>();

  final List<String> list = <String>["Kiralık", "Satılık"];
  final List<String> list2 = <String>[
    "0",
    "1+0",
    "2+1",
    "3+1",
    "4+1",
    "5+1",
    "6+2"
  ];
  final List<String> list3 = <String>["Ev", "Villa", "Ofis", "Arsa"];

  String _chosenValue = "Kiralık";
  String _chosenValue2 = "1+0";
  String _chosenValue3 = "Ev";

  RealEstates realEstates = RealEstates.empty();
  RealEstatesIMG realEstatesIMG = RealEstatesIMG();

  String urls = "http://localhost:8060/api/realEstates/saveRealEstates";
  String url3 = "http://localhost:8060/api/realEstates/uploadImage";

  Widget build(BuildContext context) {
    Future saves() async {
      var res = await http.post(Uri.parse(urls),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'headerText': realEstates.headerText,
            'bodyText': realEstates.bodyText,
            'rentSale': realEstates.rentSale,
            'price': realEstates.price,
            'squareMeters': realEstates.squareMeters,
            'roomNumbers': realEstates.roomNumbers,
            'buildAge': realEstates.buildAge,
            'realEstateType': realEstates.realEstateType,
            'sellerPhone': realEstates.sellerPhone,
            'sellersCompany': realEstates.sellersCompany
          }));
      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 202 ||
          res.statusCode == 203 ||
          res.statusCode == 204) {
        var data = jsonDecode(res.body);
        realEstatesIMG.id = data["id"];
        print(data["id"]);
        print(data["bodyText"]);
        print(res.body);
      }
    }

    Future imageSave() async {
      var res = await http.post(Uri.parse(url3),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'id': realEstatesIMG.id,
            'base64': realEstatesIMG.base64.toString(),
          }));
      // print(rest.body);
    }

    final headerTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.headerText),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        realEstates.headerText = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'başlık boş';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.view_headline_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Başlık",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final bodyTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.bodyText),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        realEstates.bodyText = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'başlık boş';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.text_snippet_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "ana Metin",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final priceField = TextFormField(
      autofocus: false,
      //controller: fiyatTyc,
      keyboardType: TextInputType.number,
      //validator:(){} ,
      onChanged: (value) {
        //int value = int.parse(realEstates.fiyat.toString());
        //realEstates.fiyat = value;
        realEstates.price = int.parse(value);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'kaç lira';
        }

        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.monetization_on_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "kaç lira",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final squareMetersField = TextFormField(
      autofocus: false,
      //controller: metreKareTyc,
      keyboardType: TextInputType.number,
      //validator:(){} ,
      onChanged: (value) {
        // int value = int.parse(realEstates.metrekare.toString());
        realEstates.squareMeters = int.parse(value);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'kaç metre kare';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.home),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "metrekare",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final roomNumbersField = TextFormField(
      autofocus: false,
      //controller: binaYasiTyc,
      keyboardType: TextInputType.name,
      //validator:(){} ,

      validator: (value) {
        if (value!.isEmpty) {
          return ' binaYasi';
        }
        return null;
      },
      onChanged: (value) {
        //int value = int.parse(realEstates.binaYasi.toString());
        realEstates.buildAge = int.parse(value);
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.app_registration),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "binaYasi",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen.shade400)),
      ),
    );

    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen.shade400,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //print(realEstates.toString());
          if (_formKey.currentState!.validate()) {
            saves().then((value) => imageSave());
          }
          Navigator.of(context).pop();
        },
        child: Text(
          "Gayrimenkul Ekle",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final sellerPhoneField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.sellerPhone),
      keyboardType: TextInputType.number,
      //validator:(){} ,
      onChanged: (value) {
        realEstates.sellerPhone = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'başlık boş';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.view_headline_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Emlekçı",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final sellersCompanyField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.sellersCompany),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        realEstates.sellersCompany = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'başlık boş';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.view_headline_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Emlakçı İsmi",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/logo.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    DropdownButton<String>(
                      value: _chosenValue,
                      style: TextStyle(color: Colors.black),
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Please choose a language",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onChanged: (String? value) {
                        realEstates.rentSale = value;
                        setState(() {
                          _chosenValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: _chosenValue2,
                      style: TextStyle(color: Colors.black),
                      items:
                          list2.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Please choose a language",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onChanged: (String? value) {
                        realEstates.roomNumbers = value;
                        setState(() {
                          _chosenValue2 = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: _chosenValue3,
                      style: TextStyle(color: Colors.black),
                      items:
                          list3.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Please choose a language",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onChanged: (String? value) {
                        realEstates.realEstateType = value;
                        setState(() {
                          _chosenValue3 = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    headerTextField,
                    SizedBox(
                      height: 20,
                    ),
                    bodyTextField,
                    SizedBox(
                      height: 20,
                    ),
                    priceField,
                    SizedBox(
                      height: 20,
                    ),
                    squareMetersField,
                    SizedBox(
                      height: 20,
                    ),
                    sellerPhoneField,
                    SizedBox(
                      height: 20,
                    ),
                    sellersCompanyField,
                    SizedBox(
                      height: 20,
                    ),
                    roomNumbersField,
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ImagePickers(
                      realEstatesIMG: realEstatesIMG,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    saveButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
