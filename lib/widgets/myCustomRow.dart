import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  const MyRow({Key? key, required this.baslik, required this.deger})
      : super(key: key);
  final String baslik;
  final String deger;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 2, child: Center(child: Text(baslik))),
      Expanded(flex: 1, child: SizedBox.shrink()),
      Expanded(flex: 1, child: Center(child: Text(deger)))
    ]);
  }
}
