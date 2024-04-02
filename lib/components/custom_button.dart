// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final dynamic onPressed;
  final String text;
  final double size;
   final Color color;
  final  String? leftAssetValue;
  final  String? rightAssetValue;
   const CustomButton({
    Key? key,
     required this.onPressed,
    required this.text,
     this.size=18,
     this.color=white,
     this.leftAssetValue,
     this.rightAssetValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: lightBlueThemeColor,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          
                            decoration: BoxDecoration(
        
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: buttonBorder),
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
                               if (leftAssetValue != null)
                                Image.asset(leftAssetValue!), //if icon is provided, then its shown on the left
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.7.h,horizontal: 2.w),
                                  child: Text(
                                   text,
                                    style: GoogleFonts.metrophobic(
                                        color: color, fontSize: size),
                                  ),
                                ),
                                    if (rightAssetValue != null)
                                   Image.asset(rightAssetValue!),//if icon is provided, then its shown on the right
                              ],
                            ),
                          ),
      ),
    );
}
}
