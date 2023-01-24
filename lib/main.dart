import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:hazar_emlak/pages/welcome.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Welcome(),
    );
  }
}
