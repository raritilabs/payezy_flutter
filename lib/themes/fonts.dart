import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';


Widget metrophobicText(String text,{Color color=white,double size=16,TextAlign textAlign=TextAlign.left,double spacing = -0.3,double height=1.5}){
    return Text(
    textAlign: textAlign,
    text,
    style: GoogleFonts.metrophobic(
      color: color,
      fontSize: size,
      letterSpacing:spacing, 
      height: height,
      
    ),
  );
}

Widget robotoText(String text,{Color color=white,double size=16,TextAlign textAlign=TextAlign.left,double spacing = -0.3}){
    return Text(

    textAlign: textAlign,
    text,
    style: GoogleFonts.roboto(
      color: color,
      fontSize: size,
      letterSpacing:spacing, 
      
    ),
  );
}