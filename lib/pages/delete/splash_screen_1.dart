import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/pages/onboarding_screen.dart';
import 'package:payezy/themes/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3),(){
 Navigator.of(context).push(_createRoute(const OnboardingScreen()));
     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OnboardingScreen(),),);
    });
    super.initState();
   
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            resizeToAvoidBottomInset: false,

      backgroundColor: mainBackgroundColor,
      body: Center(
        child:Image.asset('assets/payezeySplashIcon.gif',
        )
        
        //Image.asset('assets/payezyLogo.png'),
      )
    );
  }
}

 Route<Object?> _createRoute(Widget route) {
    return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //const begin = Offset(1, 1);
     // const end = Offset.zero;
   //   final tween = Tween(begin: begin, end: end);
 // final offsetAnimation = animation.drive(tween);

      return FadeTransition( 
      opacity:animation,
        child: child,
      );
    },
  );
  }