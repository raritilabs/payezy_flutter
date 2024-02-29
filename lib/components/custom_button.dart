import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/themes/colors.dart';

Widget customButton(onPressed,String text,double size,bool value, Color color) {
  return Container(
                       // width: double.infinity,
                        decoration: BoxDecoration(
                          
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                colors: [
                                  proceedButtonGradient1,
                                  proceedButtonGradient2
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: onPressed,
                                child:  Text(
                                 text,
                                  style: GoogleFonts.metrophobic(
                                      color: color, fontSize: size),
                                )),
                                Visibility(
                                  visible: value,
                                  child: IconButton(onPressed: (){}, icon: Image.asset('assets/nextIcon.png'),
                                
                                 ),
                                ),
                          ],
                        ),
                      );
}