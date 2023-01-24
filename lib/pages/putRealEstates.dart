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
        TextEditingController(text: realEstates.buildAge.toString());
    var fiyatTyc = TextEditingController(text: realEstates.price.toString());
    var metreKareTyc =
        TextEditingController(text: realEstates.squareMeters.toString());

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

    final rentSaleTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.rentSale),
      onChanged: (value) {
        realEstates.rentSale = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.rentSale,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final priceTextField = TextFormField(
      autofocus: false,
      controller: fiyatTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.price.toString());
        realEstates.price = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.price.toString(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final squareMetersTextField = TextFormField(
      autofocus: false,
      controller: metreKareTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.squareMeters.toString());
        realEstates.squareMeters = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.squareMeters.toString(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final roomNumbersTextField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: realEstates.roomNumbers),
      onChanged: (value) {
        realEstates.roomNumbers = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.roomNumbers,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final buildAgeTextField = TextFormField(
      autofocus: false,
      controller: binaYasiTyc,
      onChanged: (value) {
        int value = int.parse(realEstates.buildAge.toString());
        realEstates.buildAge = value;
      },
      validator: (val) {
        if (val!.isEmpty) {
          return 'BodyText is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: realEstates.buildAge.toString(),
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
            rentSaleTextField,
            SizedBox(
              height: 15,
            ),
            squareMetersTextField,
            SizedBox(
              height: 15,
            ),
            priceTextField,
            SizedBox(
              height: 15,
            ),
            roomNumbersTextField,
            SizedBox(
              height: 15,
            ),
            buildAgeTextField,
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
