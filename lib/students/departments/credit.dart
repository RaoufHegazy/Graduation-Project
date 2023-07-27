import 'package:flutter/material.dart';

import '../../services(R)/cloud/cloud_user.dart';
import '../CS_levels.dart';
import '../constants.dart';
import '../widgets/folder.dart';
class Credit extends StatefulWidget {
  final CloudUser cloud_user;

  Credit({required this.cloud_user});

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        title: const Text("Credit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Folder(
                  name: "Cyber Security",
                  where:  Levels(level: "Cyber Security",cloud_user: widget.cloud_user, ),
                  textColor: Colors.black,
                  backgroundImage: "images/hacker.jpg"),
              Folder(
                  name: "Medical",
                  where:  Levels(level: "Medical",cloud_user: widget.cloud_user, ),
                  textColor: Colors.black,
                  backgroundImage: "images/medical.jpg")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Folder(
                name: "Automation",
                where:  Levels(level: "Automation",cloud_user: widget.cloud_user, ),
                textColor: Colors.black,
                backgroundImage: "images/mechatronics.jpg",
              ),
              Folder(
                name: "Networks",
                where:  Levels(level: "Networks",cloud_user: widget.cloud_user, ),
                textColor: Colors.black,
                backgroundImage: "images/network2.jpg",
              )
            ],
          )
        ],
      ),
    );
  }
}
