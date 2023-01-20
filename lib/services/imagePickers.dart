import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hazar_emlak/models/real_estates_img.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  ImagePickers({Key? key, required this.realEstatesIMG}) : super(key: key);
  RealEstatesIMG realEstatesIMG;
  @override
  State<ImagePickers> createState() => _ImagePickersState();
}

class _ImagePickersState extends State<ImagePickers> {
  File? imageFile;
  Future selectFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final byte = await image.readAsBytes();
      final imageEncoded = base64Encode(byte);
      widget.realEstatesIMG.base64 = imageEncoded;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.lightGreen.shade400),
        child: const Text("galeriden img al"),
        onPressed: () {
          selectFile();
        },
      ),
    );
  }
}
