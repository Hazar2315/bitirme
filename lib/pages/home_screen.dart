import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/models/real_estates_filter.dart';
import 'package:hazar_emlak/pages/show_detail.dart';
import 'package:hazar_emlak/services/real_estates_service.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> list = <String>["", "Kiralık", "Satılık"];
  final List<String> list2 = <String>[
    "",
    "1+0",
    "1+1",
    "2+1",
    "3+1",
    "4+1",
    "5+1",
    "6+2"
  ];
  final List<String> list3 = <String>["", "Ev", "Villa", "Bina", "Arsa"];

  String _chosenValue = "";
  String _chosenValue2 = "";
  String _chosenValue3 = "";

  RealEstatesFilter realEstatesFilter = RealEstatesFilter();
  RealEstatesService realEstates = RealEstatesService();

  List<RealEstates>? realEstatesFilters;
  // List<Map<RealEstatesFilter, dynamic>> empty = [];
  String urls = "http://localhost:8060/api/realEstates/listFilter";

  Future<List<RealEstates>> filters() async {
    print("object");
    var res = await http.post(Uri.parse(urls),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'kiralikSatilik': realEstatesFilter.kiralikSatilik,
          'odaSayisi': realEstatesFilter.odaSayisi,
          'realEstateType': realEstatesFilter.realEstateType,
          'minFiyat': realEstatesFilter.minFiyat,
          'maxFiyat': realEstatesFilter.maxFiyat,
          'minBinaYasi': realEstatesFilter.maxBinaYasi,
          'maxBinaYasi': realEstatesFilter.maxBinaYasi,
          'fiyat': realEstatesFilter.fiyat,
          'metrekare': realEstatesFilter.metrekare,
          'binaYasi': realEstatesFilter.binaYasi,
          'minMetrekare': realEstatesFilter.minMetrekare,
          'maxMetrekare': realEstatesFilter.maxMetrekare,
        }));
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 202 ||
        res.statusCode == 203 ||
        res.statusCode == 204) {
      print(res.body);
      var decodeData = utf8.decode(res.bodyBytes);
      List<dynamic> data = jsonDecode(decodeData);
      List<RealEstates> realEstates =
          //realEstatesFilters =
          data.map((dynamic item) => RealEstates.fromJson(item)).toList();
      return realEstates;
    } else {
      throw "cant get post";
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    realEstatesFilters = await filters() as List<RealEstates>?;
    setState(() {
      isLoading = false;
    });
  }

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final minFiyatField = TextFormField(
      autofocus: false,
      // controller:TextEditingController(text: realEstatesFilter.minFiyat.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        //int value = int.parse(realEstatesFilter.minFiyat.toString());
        realEstatesFilter.minFiyat = int.parse(value);
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
        contentPadding: EdgeInsets.all(5),
        hintText: "min Fiyat",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final maxFiyatField = TextFormField(
      autofocus: false,
      //  controller:TextEditingController(text: realEstatesFilter.maxFiyat.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        // int value = int.parse(realEstatesFilter.maxFiyat.toString());
        realEstatesFilter.maxFiyat = int.parse(value);
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
        hintText: "max Fiyat",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final minBinaYasiField = TextFormField(
      autofocus: false,
      // controller:TextEditingController(text: realEstatesFilter.minBinaYasi.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        // int value = int.parse(realEstatesFilter.minBinaYasi.toString());
        realEstatesFilter.minBinaYasi = int.parse(value);
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
        hintText: "min bina yaşı",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final maxBinaYasiField = TextFormField(
      autofocus: false,
      //controller:TextEditingController(text: realEstatesFilter.maxBinaYasi.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        realEstatesFilter.maxBinaYasi = int.parse(value);
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
        hintText: "max bina yaşı",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final maxMetrekareField = TextFormField(
      autofocus: false,
      // controller: TextEditingController(text: realEstatesFilter.maxMetrekare.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        realEstatesFilter.maxMetrekare = int.parse(value);
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
        hintText: "max metrekare",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final minMetrekareField = TextFormField(
      autofocus: false,
      //controller: TextEditingController(text: realEstatesFilter.minMetrekare.toString()),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        //int value = int.parse(realEstatesFilter.minMetrekare.toString());
        realEstatesFilter.minMetrekare = int.parse(value);
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
        hintText: "min metrekare",
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
          //print(realEstates.toString());
          getData();
        },
        child: Text(
          "Filtrele",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.filter_alt_sharp,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightGreen.shade400,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) =>
                      buildFiltersScreen(
                          saveButton,
                          minFiyatField,
                          maxFiyatField,
                          minBinaYasiField,
                          maxBinaYasiField,
                          minMetrekareField,
                          maxMetrekareField,
                          setModalState)));
        },
      ),
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green.shade400,
            ),
            Text(
              "Türkiye Konya",
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey.shade600,
              ),
              onPressed: () {})
        ],
      ),
      // drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 10,
                child: isLoading
                    ? Text("loading")
                    : ListView.builder(
                        itemCount: realEstatesFilters!.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(realEstatesFilters![index].id),
                          color: Colors.lightGreen.shade400,
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: Text(
                                "Başlık: " +
                                    realEstatesFilters![index].headerText! +
                                    "      Durum : " +
                                    realEstatesFilters![index].kiralikSatilik! +
                                    "\n      Gayrimenkul Türü : " +
                                    realEstatesFilters![index].realEstateType!,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text("Fiyat : " +
                                  realEstatesFilters![index].fiyat.toString() +
                                  "      metrekare/Dönüm : " +
                                  realEstatesFilters![index]
                                      .metrekare
                                      .toString()),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ShowDetail(
                                          realEstate:
                                              realEstatesFilters![index])))),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  Padding buildFiltersScreen(
      Material saveButton,
      TextFormField minFiyatField,
      TextFormField maxFiyatField,
      TextFormField minBinaYasiField,
      TextFormField maxBinaYasiField,
      TextFormField minMetrekareField,
      TextFormField maxMetrekareField,
      StateSetter setModalState) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
                child: Text("Durum : "),
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
                  realEstatesFilter.kiralikSatilik = value;
                  setModalState(() {
                    print("choosen value $_chosenValue");
                    print("choosen value $value");
                    _chosenValue = value!;
                  });
                },
              ),
              SizedBox(
                height: 15,
                child: Text("Oda Sayısı : "),
              ),
              DropdownButton<String>(
                value: _chosenValue2,
                style: TextStyle(color: Colors.black),
                items: list2.map<DropdownMenuItem<String>>((String value) {
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
                  realEstatesFilter.odaSayisi = value;
                  setModalState(() {
                    _chosenValue2 = value!;
                  });
                },
              ),
              SizedBox(
                height: 15,
                child: Text("Gayrimenkul Tipi : "),
              ),
              DropdownButton<String>(
                value: _chosenValue3,
                style: TextStyle(color: Colors.black),
                items: list3.map<DropdownMenuItem<String>>((String value) {
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
                  realEstatesFilter.realEstateType = value;
                  setModalState(() {
                    _chosenValue3 = value!;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              minFiyatField,
              SizedBox(
                height: 5,
              ),
              maxFiyatField,
              SizedBox(
                height: 5,
              ),
              minMetrekareField,
              SizedBox(
                height: 5,
              ),
              maxMetrekareField,
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              minBinaYasiField,
              SizedBox(
                height: 5,
              ),
              maxBinaYasiField,
              SizedBox(
                height: 5,
              ),
              saveButton
            ],
          ),
        ),
      ),
    );
  }
}
