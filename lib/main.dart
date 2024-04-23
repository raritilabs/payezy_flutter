import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:payezy/pages/home_page.dart';
import 'package:payezy/pages/login_page.dart';
import 'package:payezy/pages/main_screen.dart';
import 'package:payezy/pages/profilePages/help_and_support.dart';
import 'package:payezy/pages/profilePages/profile.dart';
import 'package:payezy/pages/sendPages/cybrid.dart';
import 'package:payezy/pages/sendPages/enter_details.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/pages/sendPages/send_page.dart';
import 'package:payezy/pages/sign_up.dart';
import 'package:payezy/pages/splash_screen.dart';
import 'package:payezy/pages/transferPages/fetch_data.dart';
import 'package:payezy/pages/verify_email.dart';
import 'package:payezy/providers/error_provider.dart';
import 'package:payezy/providers/ifsc_validator.dart';
import 'package:payezy/providers/enter_details_provider.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/providers/login_provider.dart';
import 'package:payezy/providers/nav_provider.dart';
import 'package:payezy/providers/profile_page_provider.dart';
import 'package:payezy/providers/review_and_ratings_provider.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await dotenv.load(fileName: '.env');
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
        ChangeNotifierProvider<NavigationProvider>(create:(context) => NavigationProvider()),
        ChangeNotifierProvider<ApiProvider>(create:(context) => ApiProvider()),
        ChangeNotifierProvider<LoginProvider>(create:(context) => LoginProvider()),
        ChangeNotifierProvider<ErrorProvider>(create:(context) => ErrorProvider()),
        ChangeNotifierProvider<ProfilePageProvider>(create: (context)=> ProfilePageProvider()),
        ChangeNotifierProvider<ReviewAndRatingsProvider>(create: (context)=> ReviewAndRatingsProvider())

      ],
    
     child:Sizer(
      builder:(context,orientation,deviceType){
return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Payezy Mobile App',
        home: const SplashScreen(),
        routes: {
          sendPage:(context)=> const SendPage(),
          enterDetailsPage:(context) =>const EnterDetails(),
          cybrid:(context)=>const Cybrid(),
          signupPage:(context)=>const SignUp(),
          getStartedPage:(context)=>const GetStarted(),
          profile:(context)=>const Profile(),
          transfer:(context)=>const FetchData(),
          fetchData:(context)=>const FetchData(),
          loginPage:(context)=>const LoginPage(),
          mainScreen:(context)=>const MainScreen(),
          verifyEmail:(context)=>const VerifyEmail(),
          transferHistory:(context)=>const TransferHistory(),
          homePage:(context)=>const HomePage(),
          helpAndSupport:(context)=>const HelpAndSupportHomePage(),
          reviewPage:(context)=>const ReviewPage(),
          failedTransaction:(context)=>const FailedTransaction(),
        }
         );
         
      }
      
     ));
  }
}

