import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  Users users = Users("", "", "", "", "");
  String url = "http://localhost:8060/api/users/register";
  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': users.email,
          'userName': users.userName,
          'surName': users.surName,
          'password': users.password,
          'role': users.role
        }));
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    users.role = "USER";
    final nameField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: users.userName),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        users.userName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Adınız",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //Sirname Editing Field
    final sirNameField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: users.surName),
      keyboardType: TextInputType.name,
      //validator:(){} ,
      onChanged: (value) {
        users.surName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Soyadınız",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //email Editing Field
    final emailField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: users.email),
      keyboardType: TextInputType.emailAddress,
      //validator:(){} ,
      onChanged: (value) {
        users.email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mail Adresiniz ",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //password Editing Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: TextEditingController(text: users.password),
      obscureText: true,
      //validator:(){} ,
      onChanged: (value) {
        users.password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'password is Empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "şifreniz",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    //Signup Button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen.shade400,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            save();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.lightGreen.shade400),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    nameField,
                    SizedBox(
                      height: 20,
                    ),
                    sirNameField,
                    SizedBox(
                      height: 20,
                    ),
                    emailField,
                    SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    SizedBox(
                      height: 45,
                    ),
                    signUpButton,
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
