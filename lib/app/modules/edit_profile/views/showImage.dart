import 'dart:io';

import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.isfile, required this.imagePath});
  final bool isfile;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: isfile ? Image.file(File(imagePath)) : Image.network(imagePath),
    ));
  }
}
