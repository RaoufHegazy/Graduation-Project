
import 'package:flutter/material.dart';

import '../../services(R)/cloud/cloud_user.dart';
import '../CS_levels.dart';
import '../constants.dart';
import '../widgets/folder.dart';

class ComputerScience extends StatefulWidget {
  final CloudUser cloud_user;

  ComputerScience({required this.cloud_user});

  @override
  State<ComputerScience> createState() => _ComputerScienceState();
}

class _ComputerScienceState extends State<ComputerScience> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        title: const Text("Computer Science"),
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
                    name: "level 1",
                    where:  Levels(level: "CSlevel 1",cloud_user: widget.cloud_user, ),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/22.jpg",
                    name: "level 2",
                    where:  Levels(level: "CSlevel 2",cloud_user: widget.cloud_user, ),
                    textColor: Colors.black)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                    backgroundImage: "images/33.jpg",
                    name: "level 3 ",
                    where:  Levels(level: "CSlevel 3",cloud_user: widget.cloud_user, ),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/44.jpg",
                    name: "level 4",
                    where:  Levels(level: "CSlevel 4",cloud_user: widget.cloud_user, ),
                    textColor: Colors.black)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
