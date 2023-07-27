import 'package:flutter/material.dart';

class AnimatedImage extends StatelessWidget {
  AnimatedImage(
      {Key? key,
      required this.imageTrack,
      required this.tag,
      required this.trackName});
  String imageTrack = "";
  String tag = "";
  String trackName = "x";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                backgroundBlendMode: BlendMode.darken),
            height: 80,
            child: Card(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () => _showSecondPage(context),
                  child: Hero(
                    tag: tag,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/com.jpg'),
                    ),
                  ),
                ),
                title: Text(
                  trackName,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(title: Text('$trackName')),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Hero(
                tag: tag,
                child: Image.asset(
                  imageTrack,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
