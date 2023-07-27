import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

import '../services(R)/cloud/cloud_user.dart';
import 'departments.dart';

class FacultyImages extends StatefulWidget {
  final CloudUser cloud_user;


  FacultyImages({required this.cloud_user});

  @override
  State<FacultyImages> createState() => _FacultyImagesState();
}

class _FacultyImagesState extends State<FacultyImages> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return  Departments(cloud_user: widget.cloud_user,);
          }));
        },
        finishCallback: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return  Departments(cloud_user: widget.cloud_user,);
          }));
        },
      ),
    );
  }

  final pages = [
    PageModel.withChild(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/5.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        color: Colors.amber),
    PageModel.withChild(
        child: Container(
          width: double.infinity - 600,
          height: 1000,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/4.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        color: Colors.amber),
    PageModel.withChild(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/6.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        color: Colors.amber),
    PageModel.withChild(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/drAyman.JPG'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      color: const Color(0xFF5886d6),
      doAnimateChild: false,
    ),
  ];
}
