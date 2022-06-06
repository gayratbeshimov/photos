import 'package:flutter/material.dart';
import 'package:photos/image_hero.dart';

class Images extends StatelessWidget {
  const Images({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageHero()));
                print("alo");
              },
              child: Hero(
                  tag: 'Hero',
                  child: Image.network("https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500")),
            ),
            SizedBox(height: 15,),
            Image.network("https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
            Image.network("https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500"),

          ],

        ),
      ),
    );
  }
}
