import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates_filter.dart';
import 'package:hazar_emlak/models/user.dart';
import 'package:hazar_emlak/pages/user_detail.dart';
import 'package:hazar_emlak/pages/welcome.dart';
import 'package:hazar_emlak/services/user_service.dart';
import 'package:hazar_emlak/widgets/NavigationDrawerWdiget.dart';
import 'package:http/http.dart' as http;
import '../models/rating.dart';
import '../services/ratingService.dart';
import 'add_real_estates.dart';

class ShowUsers extends StatefulWidget {
  ShowUsers({Key? key}) : super(key: key);

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  List<Users4>? userSearch;
  Ratings rating = Ratings();
  List<Ratings>? ratingsList;
  Users3 users = Users3();

  String urls = "http://localhost:8060/api/users/search";
  Future<List<Users4>> search() async {
    print("object");
    var res = await http.post(Uri.parse(urls),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "userName": users.userName.toString(),
          'odaSayisi': users.surName.toString(),
          'realEstateType': users.role.toString(),
        }));
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 202 ||
        res.statusCode == 203 ||
        res.statusCode == 204) {
      print(res.body);
      var decodeData = utf8.decode(res.bodyBytes);

      List<dynamic> data = jsonDecode(decodeData);

      List<Users4> userList =
          //realEstatesFilters =
          data.map((dynamic item) => Users4.fromJson(item)).toList();

      return userList;
    } else {
      throw "cant get post";
    }
  }

  bool commentLoading = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    users.userName = "";
    getData();
    getComment();
  }

  getComment() async {
    setState(() {
      commentLoading = true;
    });
    final List<Ratings> response = await RatingService().getAllPost();
    print(response.toString());
    ratingsList = response;
    setState(() {
      commentLoading = false;
    });
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    userSearch = await search();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchBox = TextFormField(
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          icon: Icon(Icons.search)),
      onChanged: (value) {
        users.userName = value;
        getData();
      },
    );
    //final UserService userService = UserService();

    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("Kullanıcılar"),
          backgroundColor: Colors.lightGreen.shade400,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(flex: 2, child: searchBox),

            Expanded(
                flex: 10,
                child: isLoading
                    ? Text("loading")
                    : ListView.builder(
                        itemCount: userSearch!.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(userSearch![index].id),
                          color: Colors.lightGreen.shade400,
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: Text(
                                "User id : " +
                                    userSearch![index].id.toString() +
                                    " User email : " +
                                    userSearch![index].email!,
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text("Kullanıcı İsmi : " +
                                  userSearch![index].userName! +
                                  " " +
                                  userSearch![index].surName!),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => UserDetail(
                                          users: userSearch![index])))),
                        ),
                      )),
            ratingsList == null
                ? Text("no comments")
                : Expanded(
                    flex: 5,
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
                          subtitle: Text("Kullanıcı:" +
                              ratingsList![index].user!.email +
                              " Gayrimenkul no : " +
                              ratingsList![index].realEstates!.id.toString() +
                              " Gayrimenkul Puanı : " +
                              ratingsList![index].ratings.toString() +
                              "/5"),
                          iconColor: Colors.green.shade400,
                        ),
                      ),
                    ),
                  ),

            // FutureBuilder(
            //     future: userService.getPost(),
            //     builder:
            //         (BuildContext context, AsyncSnapshot<List<Users2>> snapshot) {
            //       if (snapshot.hasData) {
            //         List<Users2> users = snapshot.data!;
            //         return ListView(
            //           children: users
            //               .map((Users2 users) => ListTile(
            //                     title: Text("User id : " +
            //                         users.id.toString() +
            //                         " User mail : " +
            //                         users.email),
            //                     subtitle: Text("Kullanıcı Adı : " +
            //                         users.userName +
            //                         " " +
            //                         users.surName),
            //                     onTap: () => Navigator.of(context).push(
            //                         MaterialPageRoute(
            //                             builder: (context) =>
            //                                 UserDetail(users: users))),
            //                   ))
            //               .toList(),
            //         );
            //       }
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );

            //       //}
            //     }),
            //
          ],
        ));
  }
}
