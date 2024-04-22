// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:payezy/themes/colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
   Color? color1=mainCardGradient1;
   Color? color2=mainCardGradient2;
   CustomContainer({
    Key? key,
    this.child,
    this.color1,
    this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                  gradient:  LinearGradient(
                      colors: [color1 ?? mainCardGradient1, color2 ?? mainCardGradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(5)),
              width: double.maxFinite,
              
              child:child);
  }
}
