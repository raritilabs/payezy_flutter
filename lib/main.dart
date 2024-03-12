import 'package:flutter/material.dart';
import 'package:payezy/pages/login_page.dart';
import 'package:payezy/pages/profilePages/profile.dart';
import 'package:payezy/pages/sendPages/cybrid.dart';
import 'package:payezy/pages/sendPages/enter_details.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/pages/home_page.dart';
import 'package:payezy/pages/sign_up.dart';
import 'package:payezy/pages/splash_screen_1.dart';
import 'package:payezy/pages/transferPages/fetch_data.dart';
import 'package:payezy/pages/transferPages/transfer.dart';
import 'package:payezy/providers/enter_details.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


void main()  {
 WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider<GetStartedProvider>(create:(context) => GetStartedProvider()),
        ChangeNotifierProvider<EnterDetailsProvider>(create:(context) => EnterDetailsProvider()),
        ChangeNotifierProvider<FetchDataProvider>(create:(context) => FetchDataProvider()),
      ],
    
     child:Sizer(
      builder:(context,orientation,deviceType){
return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Payezy Mobile App',
        home: const Splash(),
        routes: {
          homePage:(context)=> const HomePage(),
          enterDetailsPage:(context) =>const EnterDetails(),
          cybrid:(context)=>const Cybrid(),
          signupPage:(context)=>const SignUp(),
          getStarted:(context)=>const GetStarted(),
          profile:(context)=>const Profile(),
          transfer:(context)=>const TransferPage(),
          fetchData:(context)=>const FetchData(),
          loginPage:(context)=>const LoginPage(),

        }
         );
         
      }
      
     ));
  }
}

