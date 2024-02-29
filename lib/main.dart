import 'package:flutter/material.dart';
import 'package:payezy/pages/cybrid.dart';
import 'package:payezy/pages/enter_details.dart';
import 'package:payezy/pages/home_page.dart';
import 'package:payezy/pages/splash_screen.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:provider/provider.dart';


void main()  {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<SendPageProvider>(create:(context) => SendPageProvider()),
      ],
    
     child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payezy Mobile App',
      home: const SplashScreen(),
      routes: {
        homePage:(context)=> const HomePage(),
        enterDetailsPage:(context) =>const EnterDetails(),
        cybrid:(context)=>const Cybrid(),
      }

    ));
  }
}

