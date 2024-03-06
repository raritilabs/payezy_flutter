import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payezy/pages/intro_page.dart';
import 'package:payezy/themes/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: 
    LottieBuilder.asset('assets/splashAnimation.json'),nextScreen:const IntroPage(),
    splashIconSize: 900,
     );
  }
}