import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photos/data/data.dart';
import 'package:photos/model/categories_model.dart';
import 'package:photos/model/wallpaper_model.dart';
import 'package:photos/views/categories.dart';
import 'package:photos/views/search.dart';
import 'package:photos/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];

  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper() async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=coding&per_page=80&page=1"),
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
    getTrendingWallpaper();
    categories = getCategories();
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
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      imgUrl: categories[index].imgUrl ?? "",
                      title: categories[index].categoriesName ?? "",
                    );
                  },
                ),
              ),
              wallpaperList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  CategoriesTile({Key? key, required this.imgUrl, required this.title})
      : super(key: key);
  String imgUrl;
  String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(
              categoriesName: title.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
