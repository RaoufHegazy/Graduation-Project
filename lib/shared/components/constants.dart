import 'package:flutter/material.dart';

void print_full_text (String text) {
  final pattern =RegExp('.{1800}');
  pattern.allMatches('text').forEach((match)=>print(match.group(0)));

}


// colors (2 methods)  start with 0xff + code of color
Color myColor = Color(0xff87ceeb);
Color myColor2 = HSLColor.fromColor(Color(0xff1d1a39)).toColor();

String UserType='';