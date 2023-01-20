import 'package:flutter/material.dart';
import 'package:hazar_emlak/pages/login_screen.dart';
import 'package:hazar_emlak/pages/registration_screen.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final login_page_Button = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.lightGreen.shade400,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Text(
          "Giriş Yap",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final logup_page_Button = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(50),
      color: Colors.lightGreen.shade400,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()));
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400,
                    child: Image.asset(
                      "assets/logo.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  login_page_Button,
                  SizedBox(
                    height: 25,
                  ),
                  logup_page_Button,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
