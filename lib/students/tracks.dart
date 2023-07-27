import 'package:flutter/material.dart';
import 'package:v46/students/widgets/animatedImageView.dart';

import 'constants.dart';

class Tracks extends StatelessWidget {
  const Tracks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("Tracks"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedImage(
                imageTrack: "images/embedded.png",
                tag: "avatar",
                trackName: "Embedded System",
              ),
              AnimatedImage(
                  imageTrack: "images/FlutterRoadmap.png",
                  tag: "photo",
                  trackName: "Flutter"),
              AnimatedImage(
                  imageTrack: "images/syber.png",
                  tag: "cyber",
                  trackName: "cyber security"),
              AnimatedImage(
                  imageTrack: "images/network.jpg",
                  tag: "network",
                  trackName: "Computer Networks"),
              AnimatedImage(
                  imageTrack: "images/machine_learning.png",
                  tag: "ml",
                  trackName: "Machine learning"),
              AnimatedImage(
                  imageTrack: "images/front.png",
                  tag: "front",
                  trackName: "Front-End"),
              AnimatedImage(
                  imageTrack: "images/dev.png",
                  tag: "dev",
                  trackName: "DevOps"),
              AnimatedImage(
                  imageTrack: "images/data-science-roadmap2.jpg",
                  tag: "ds",
                  trackName: "Data science"),
              AnimatedImage(
                  imageTrack: "images/backend.jpg",
                  tag: "back",
                  trackName: "Back-End")
            ],
          ),
        ),
      ),
    );
  }
}
