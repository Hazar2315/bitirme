import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xFFF8FAFC),
        hintText: "search...",
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
