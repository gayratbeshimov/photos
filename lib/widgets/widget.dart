import 'package:flutter/material.dart';
import 'package:photos/model/wallpaper_model.dart';
import 'package:photos/views/image_view.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        "Wallpaper",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      Text(
        "Hub",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    ],
  );
}


Widget wallpaperList(List<WallpaperModel> wallpapers, context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageView(imgUrl: wallpaper.src!.portrait ?? ""),
              ),
            );
          },
          child: Hero(
            tag: wallpaper.src!.portrait ?? "",
            child: GridTile(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src!.portrait ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
