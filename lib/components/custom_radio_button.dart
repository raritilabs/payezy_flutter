// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';

class CustomRadioButton extends StatelessWidget {
  final Widget? child;
  final dynamic onTap;
  final Color? bulletcolor;
  final String radiobuttontext;
  final Color gradientcolorone;
  final Color gradientcolortwo;

  const CustomRadioButton({
    Key? key,
    this.child,
    required this.onTap,
    this.bulletcolor,
    required this.radiobuttontext,
    required this.gradientcolorone,
    required this.gradientcolortwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
              GestureDetector(
                onTap: onTap,
                //main border
                child: Container(
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      begin: Alignment.topRight,
                      end:Alignment.bottomLeft,
                      colors: [
                          gradientcolorone,gradientcolortwo
                          ],
                          stops: const [0.0598,0.8582]),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: lightBlueThemeColor)
                    
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                  //bullet
                       Container(
                        width: 3.w,
                        height: 3.w,
                        decoration: BoxDecoration(
                          color: bulletcolor,
                          border: Border.all(color: lightBlueThemeColor),

                          borderRadius: BorderRadius.circular(50),

                        ),
                       ),
                          //gap b/w
                          SizedBox(width: 1.h,),
                        metrophobicText(radiobuttontext,size: 11.sp),
                      ],
                    ),
                  ),
                ),
              );
  }
}
