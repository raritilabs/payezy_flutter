import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
   const CustomContainer({super.key,this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [mainCardGradient1, mainCardGradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(5)),
              width: double.maxFinite,
              
              child:child);
  }
}