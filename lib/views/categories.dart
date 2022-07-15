import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:photos/model/wallpaper_model.dart';
import 'package:photos/widgets/widget.dart';

class Categories extends StatefulWidget {
  final String categoriesName;
   const Categories({Key? key, required this.categoriesName}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> wallpapers = [];


  getSearchWallpaper(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1"),
        headers: {
          "Authorization":
          "563492ad6f91700001000001321e049423344cca8accc4bda4ed554e"
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {

      WallpaperModel wallpaperModel;

      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.categoriesName);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: brandName(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              wallpaperList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}
