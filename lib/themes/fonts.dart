import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';

Widget titleText(String text) {
  return Text(
    text,
    style: GoogleFonts.metrophobic(
      color: white,
      fontSize: 15,
    ),
  );
}

Widget subtitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: greyFontThemeColor,
    ),
  );
}

Widget alertText(String text,Color color,double size){
    return Text(
    text,
    style: GoogleFonts.metrophobic(
      color: color,
      fontSize: size,
    ),
  );
}