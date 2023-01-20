import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/pages/realEstatesDetail.dart';
import 'package:hazar_emlak/services/real_estates_service.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';

import 'add_real_estates.dart';

class RealEstateViewModel {
  static final RealEstateViewModel _singleton = RealEstateViewModel._internal();

  factory RealEstateViewModel() {
    return _singleton;
  }

  static RealEstateViewModel get singleton => _singleton;

  RealEstateViewModel._internal();

  var list = ValueNotifier(<RealEstates>[]);
  RealEstatesService realEstatesService = RealEstatesService();

  getData() async {
    list.value = await realEstatesService.getPost();
  }
}

class RealEstatesList extends StatefulWidget {
  RealEstatesList({Key? key}) : super(key: key);

  @override
  State<RealEstatesList> createState() => RealEstatesListState();
}

class RealEstatesListState extends State<RealEstatesList> {
  final RealEstatesService realEstatesService = RealEstatesService();

  ValueListenable<List<RealEstates>>? list;
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

    await RealEstateViewModel.singleton.getData();
    list = RealEstateViewModel.singleton.list;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Kullanıcılar"),
          backgroundColor: Colors.lightGreen.shade400,
          elevation: 0,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.lightGreen.shade400,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    return list != null
        ? ValueListenableBuilder<List<RealEstates>>(
            valueListenable: list!,
            builder: (context, value, child) => ListView(
              children: (value as List<RealEstates>)
                  .map(
                    (RealEstates realEstates) => Card(
                        color: Colors.white,
                        elevation: 0.0,
                        child: ListTile(
                            title: Text("Header Text :" +
                                realEstates.headerText.toString()),
                            subtitle: Text("id :" + realEstates.id.toString()),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.lightGreen.shade400,
                            ),
                            leading: Icon(
                              Icons.home_filled,
                              color: Colors.lightGreen.shade400,
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RealEstatesDetail(
                                      realEstates: realEstates)));
                            })),
                  )
                  .toList(),
            ),
          )
        : Text('no data');
  }
}

/*



 */