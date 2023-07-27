import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../services(R)/cloud/cloud_user.dart';
import 'departments.dart';
import 'facultyImages.dart';

class Encouragement extends StatefulWidget {
  final CloudUser cloud_user;

  Encouragement({required this.cloud_user});
  @override
  State<Encouragement> createState() => _EncouragementState();
}

class _EncouragementState extends State<Encouragement> {
  final List<String> imgList = ["images/1.jpg", "images/2.jpg", 'images/3.jpg'];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              pauseAutoPlayOnTouch: true,
              padEnds: true,
              height: screenHeight - 120,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.ease,
              enlargeCenterPage: true,
              aspectRatio: 1,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              scrollDirection: Axis.horizontal,
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: screenHeight,
                    width: screenWidth,
                    decoration: const BoxDecoration(color: Colors.brown),
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Departments(
                          cloud_user: widget.cloud_user,
                        )),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
