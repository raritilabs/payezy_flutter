import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/pages/intro_page.dart';
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const IntroPage(),),);
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
      backgroundColor: mainBackgroundColor,
      body: Center(
        child:Image.asset('assets/payezeySplashIcon.gif',
        )
        
        //Image.asset('assets/payezyLogo.png'),
      )
    );
  }
}
