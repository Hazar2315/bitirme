import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates.dart';
import 'package:hazar_emlak/models/user.dart';
import 'package:hazar_emlak/pages/add_real_estates.dart';
import 'package:hazar_emlak/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

class Admin_Screen extends StatefulWidget {
  Admin_Screen({Key? key}) : super(key: key);

  @override
  State<Admin_Screen> createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  @override
  final UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();

  String url = "http://localhost:8060/api/users";
  List<Users2> userList = [];
  Future<List<Users2>> getPost() async {
    final response = await http.get(Uri.parse(url));
    var decodeData = utf8.decode(response.bodyBytes);
    var data = jsonDecode(decodeData);

    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(Users2.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text("Kullanıcılar"),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.lightGreen.shade400,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRealEstates(),
                    ));
              },
            )),
        body: Row(children: [
          Expanded(
              child: FutureBuilder(
                  future: getPost(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('loading');
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(userList[index].id.toString()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(userList[index]
                                              .userName
                                              .toString()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(userList[index]
                                              .surName
                                              .toString()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              userList[index].email.toString()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(userList[index]
                                              .password
                                              .toString()),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(userList[index].role.toString()),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          });
                    }
                  })),
        ]),
      ),
    );
  }
}
