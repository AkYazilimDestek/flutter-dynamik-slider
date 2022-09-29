import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADIXI REKLAM AJANSI"),
        centerTitle: true,
      ),
      body : AnaEkran(),
    );
  }
}


class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  bool loading = true;
  late List ImageList;

  fetchAllImage() async {
    final response = await http.get(Uri.parse("https://deneme.eserislamiilimlermedresesi.com/slider.json"));
    if (response.statusCode == 200) {
      setState(() {
        ImageList = jsonDecode(response.body);
        loading = false;
        print(ImageList);
      });
    }
  }

  void initState() {
    super.initState();
    fetchAllImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 150.0,
            width: double.infinity,
            child: Carousel(
              images: ImageList.map((e) {
                return Image.network(e["resim"]);
              }).toList(),
            ),
        ),

      ],
    );
  }
}
