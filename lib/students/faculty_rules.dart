
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:v46/students/pdfs/Overview.dart';
import 'package:v46/students/pdfs/depCourses.dart';
import 'package:v46/students/pdfs/study%20plan.dart';
import 'package:v46/students/widgets/folder.dart';

import 'constants.dart';

class FacultyRules extends StatefulWidget {
  FacultyRules({Key? key});

  @override
  State<FacultyRules> createState() => _FacultyRulesState();
}

class _FacultyRulesState extends State<FacultyRules> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  Future<void> _launchYouTubeVideo() async {
    const youtubeVideoUrl = 'https://www.youtube.com/watch?v=cXJe-HFhiBs&t=19s';
    if (await canLaunchUrl(Uri.parse(youtubeVideoUrl))) {
      await launchUrl(Uri.parse(youtubeVideoUrl));
    } else {
      throw 'Could not launch $youtubeVideoUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("Rules"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  height: 150,
                  width: 160,
                  child: IconButton(
                    onPressed: () {
                      _launchYouTubeVideo();
                    },
                    icon: const Icon(
                      size: 60,
                      Icons.video_library,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Department selection ",
                  style: const TextStyle(
                    color: Colors.black, // Adjust the text color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
              Folder(
                  name: "Overview",
                  where: Overview(),
                  textColor: Colors.black,
                  backgroundImage: "images/OVERVIEW.png"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Folder(
                  name: "Department courses",
                  where: DepCourses(),
                  textColor: Colors.black,
                  backgroundImage: "images/courses.jpg"),
              Folder(
                  name: "Study plan",
                  where: StudyPlan(),
                  textColor: Colors.black,
                  backgroundImage: "images/studyPlan.jpg")
            ],
          ),
        ],
      ),
    );
  }
}
