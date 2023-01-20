import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/user.dart';
import 'package:hazar_emlak/services/user_service.dart';

class UserDetail extends StatelessWidget {
  final Users4 users;
  final UserService userService = UserService();

  UserDetail({
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade400,
        title: Text(users.userName!),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade400,
        child: Icon(Icons.delete_sharp),
        onPressed: () async {
          await userService.deletePost(users.id!);
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Kullanıcı Türü"),
                  subtitle: Text(users.role!),
                ),
                ListTile(
                  title: Text("Kullanıcı ID"),
                  subtitle: Text(users.id.toString()),
                ),
                ListTile(
                  title: Text("Kullanıcı İsmi"),
                  subtitle: Text(users.userName!),
                ),
                ListTile(
                  title: Text("Kullanıcı Soyismi"),
                  subtitle: Text(users.surName!),
                ),
                ListTile(
                  title: Text("Kullanıcı email adresi"),
                  subtitle: Text(users.email!),
                ),
                ListTile(
                  title: Text("Kullanıcı Şifresi"),
                  subtitle: Text(users.password!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
