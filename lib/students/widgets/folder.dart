import 'package:flutter/material.dart';

class Folder extends StatelessWidget {
  Folder({
    super.key,
    required this.name,
    required this.where,
    required this.textColor,
    required this.backgroundImage,
  });

  String? name;
  var where;
  Color textColor;
  String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return where;
            }));
          },
          child: Container(
            alignment: Alignment.center,
            width: 160,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Text(
              '',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
            height: 10), // Adjust the spacing between the container and text
        Text(
          '$name',
          style: const TextStyle(
            color: Colors.black, // Adjust the text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  Button({super.key, required this.WhichPage, required this.track});
  var WhichPage;
  String track;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 5, 10),
        fixedSize: const Size(150, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WhichPage;
        }));
      },
      child: Text(
        track,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
