import 'package:flutter/material.dart';
import '../../services(R)/cloud/cloud_user.dart';
import '../CS_levels.dart';
import '../constants.dart';
import '../widgets/folder.dart';

class Communication extends StatefulWidget {
  final CloudUser cloud_user;

  Communication({required this.cloud_user});
  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        title: const Text("Communication"),
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
                    where:  Levels(level: "COMlevel 1",cloud_user: widget.cloud_user,),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/22.jpg",
                    name: "level 2",
                    where:  Levels(level: "COMlevel 2",cloud_user: widget.cloud_user,),
                    textColor: Colors.black)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Folder(
                    backgroundImage: "images/33.jpg",
                    name: "level 3 ",
                    where:  Levels(level: "COMlevel 3",cloud_user: widget.cloud_user,),
                    textColor: Colors.white),
                Folder(
                    backgroundImage: "images/44.jpg",
                    name: "level 4",
                    where:  Levels(level: "COMlevel 4",cloud_user: widget.cloud_user,),
                    textColor: Colors.black)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
