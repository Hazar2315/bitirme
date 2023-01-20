import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/services/real_estates_service.dart';

class PutRealEsatates extends StatefulWidget {
  PutRealEsatates({Key? key}) : super(key: key);

  @override
  State<PutRealEsatates> createState() => _PutRealEsatatesState();
}

class _PutRealEsatatesState extends State<PutRealEsatates> {
  final _formKey = GlobalKey<FormState>();
  RealEstates realEstates = RealEstates();
  final RealEstatesService realEstatesService = RealEstatesService();
  @override
  Widget build(BuildContext context) {
    var binaYasiTyc =
        TextEditingController(text: realEstates.binaYasi.toString());
    var fiyatTyc = TextEditingController(text: realEstates.fiyat.toString());
    var metreKareTyc =
        TextEditingController(text: realEstates.metrekare.toString());

    final bodyTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.bodyText),
      onChanged: (value) {
        realEstates.bodyText = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.bodyText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final headerTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.headerText),
      onChanged: (value) {
        realEstates.headerText = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.headerText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final kiralikSatilikTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.kiralikSatilik),
      onChanged: (value) {
        realEstates.kiralikSatilik = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.kiralikSatilik,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final fiyatTextField = TextFormField(
      autofocus: false,
      controller: fiyatTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.fiyat.toString());
        realEstates.fiyat = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.fiyat.toString(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final metrekareTextField = TextFormField(
      autofocus: false,
      controller: metreKareTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.metrekare.toString());
        realEstates.metrekare = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.metrekare.toString(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final odaSayisiTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.odaSayisi),
      onChanged: (value) {
        realEstates.odaSayisi = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.odaSayisi,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final binaYasiTextField = TextFormField(
      autofocus: false,
      controller: binaYasiTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.binaYasi.toString());
        realEstates.binaYasi = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.binaYasi.toString(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final realEstateTypeTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.realEstateType),
      onChanged: (value) {
        realEstates.realEstateType = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.realEstateType,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          print(realEstates.toString());
          if (_formKey.currentState!.validate()) {
            realEstatesService.UpdateRealEstates(realEstates);
          }
        },
        child: Text(
          "Kayıt Ol",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 45,
            ),
            headerTextField,
            SizedBox(
              height: 15,
            ),
            bodyTextField,
            SizedBox(
              height: 15,
            ),
            kiralikSatilikTextField,
            SizedBox(
              height: 15,
            ),
            metrekareTextField,
            SizedBox(
              height: 15,
            ),
            fiyatTextField,
            SizedBox(
              height: 15,
            ),
            odaSayisiTextField,
            SizedBox(
              height: 15,
            ),
            binaYasiTextField,
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            realEstateTypeTextField,
            SizedBox(
              height: 15,
            ),
            saveButton
          ],
        ));
  }
}
