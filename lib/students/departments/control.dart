import 'package:flutter/material.dart';
import '../../services(R)/cloud/cloud_user.dart';
import '../CS_levels.dart';
import '../constants.dart';
import '../widgets/folder.dart';

class Control extends StatefulWidget {
  final CloudUser cloud_user;

  Control({required this.cloud_user});

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        title: const Text("Control"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                    backgroundImage: "images/11.jpg",
                    name: "level 1 ",
                    where:  Levels(level: "CONlevel 1",cloud_user: widget.cloud_user,),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/22.jpg",
                    name: "level 2",
                    where:  Levels(level: "CONlevel 2",cloud_user: widget.cloud_user,),
                    textColor: Colors.black)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                    backgroundImage: "images/33.jpg",
                    name: "level 3 ",
                    where:  Levels(level: "CONlevel 3",cloud_user: widget.cloud_user,),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/44.jpg",
                    name: "level 4",
                    where:  Levels(level: "CONlevel 4",cloud_user: widget.cloud_user,),
                    textColor: Colors.black)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
