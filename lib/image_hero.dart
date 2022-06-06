import 'package:flutter/material.dart';

class ImageHero extends StatelessWidget {
  const ImageHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network("https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
    );
  }
}
