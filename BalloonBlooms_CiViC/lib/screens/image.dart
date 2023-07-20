import 'dart:io';

import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.img, this.source='asset'});
  final String img;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
      ),
      body: InteractiveViewer(
        constrained: false,
        maxScale: 3,
        child: source=='asset'? Image.asset('assets/$img.jpg', width: MediaQuery.of(context).size.width,) : Image.file(File(img), width: MediaQuery.of(context).size.width,)
      ),
    );
  }
}