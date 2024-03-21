import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/pages/sendPages/send_page.dart';
import 'package:payezy/pages/profilePages/profile.dart';
import 'package:payezy/pages/transferPages/fetch_data.dart';
import 'package:payezy/providers/nav_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final pages=[
    const SendPage(),
    const Profile(),
    const FetchData(),
  ];
  @override
  Widget build(BuildContext context) {
          final navigationProvider=Provider.of<NavigationProvider>(context);

    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainBackgroundColor,
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
          case ConnectionState.done:
        final user= FirebaseAuth.instance.currentUser;
        if(user?.emailVerified??false){
          print('you are verified');
        }
        else{
          print('verify your email');
        }
         
        default:
        CircularProgressIndicator();

  }return pages[navigationProvider.currentIndex];
  }
  ),
    );
  }
}