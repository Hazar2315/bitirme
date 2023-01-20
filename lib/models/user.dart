import 'dart:convert';

class User {
  String email;
  String password;

  // User({required this.email, required this.password});
  User(this.email, this.password);
  //Map<String, dynamic> toJson() {
  //Map<String, dynamic> map = {'email': email, 'password': password};
  //return map;
  // }
}

class Users {
  //int id;
  String userName;
  String surName;
  String email;
  String password;
  String role;

  Users(this.userName, this.password, this.email, this.surName, this.role);
}

class Users2 {
  int id;
  String userName;
  String surName;
  String email;
  String password;
  String role;

  Users2(
      {required this.id,
      required this.userName,
      required this.surName,
      required this.email,
      required this.password,
      required this.role});

  factory Users2.fromJson(Map<dynamic, dynamic> json) {
    return Users2(
      id: json['id'] as int,
      userName: json['userName'] as String,
      surName: json['surName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['surName'] = this.surName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    return data;
  }
}

class Users3 {
  String? userName;
  String? surName;
  String? role;

  Users3({this.userName, this.surName, this.role});

  factory Users3.fromJson(Map<dynamic, dynamic> json) {
    return Users3(
        userName: json['userName'],
        surName: json['surName'],
        role: json['role']);
  }
}

class Users4 {
  int? id;
  String? userName;
  String? surName;
  String? email;
  String? password;
  String? role;

  Users4(
      {this.id,
      this.userName,
      this.surName,
      this.email,
      this.password,
      this.role});
  Users4.empty();

  factory Users4.fromJson(Map<String, dynamic> json) {
    return Users4(
      id: json['id'],
      userName: json['userName'],
      surName: json['surName'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }
}
