import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hazar_emlak/models/user.dart';
import 'package:hazar_emlak/pages/home_screen.dart';
import 'package:hazar_emlak/pages/registration_screen.dart';
import 'package:hazar_emlak/pages/userList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String x = "x";
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");

  String url = "http://localhost:8060/api/users/login";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));

    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 202 ||
        res.statusCode == 203 ||
        res.statusCode == 204) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      print(data["roles"]);
      await GetStorage().write("user_id", data["id"]);
      print(res.body);
      x = "y";
      if (data["roles"] == "ADMIN") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowUsers(),
            ));
      } else if (data["roles"] == "USER") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else {}
    }
  }

  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    save();
    setState(() {
      isLoading = false;
    });
  }

  //editing controller

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      // controller: TextEditingController(text: user.email),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Lütfen mailinizi yazın';
        } else {
          value = "";
          return "lütfen mailinizi doğru girdiğinizden emin olun";
        }
      },
      onChanged: (value) {
        user.email = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.lightGreen.shade400,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      //controller: TextEditingController(text: user.password),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Lütfen şifrenizi yazın';
        } else {
          value = "";
          return "lütfen parolanızın doğru girdiğinizden emin olun";
        }
      },
      onChanged: (value) {
        user.password = value;
      },

      //validator:(){} ,

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.lightGreen.shade400,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen.shade400))),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreen.shade400,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            getData();
          } else {
            getData();
          }
        },
        child: Text(
          "Giriş",
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
                    emailField,
                    SizedBox(
                      height: 25,
                    ),
                    passwordField,
                    SizedBox(
                      height: 35,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Henüz bir hesabınız yok mu ?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text(
                            "Hesap Oluştur",
                            style: TextStyle(
                                color: Colors.lightGreen.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    )
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
