import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/pages/login_page.dart';
import 'package:payezy/pages/sendPages/send_page.dart';
import 'package:payezy/pages/profilePages/profile.dart';
import 'package:payezy/pages/transferPages/fetch_data.dart';
import 'package:payezy/pages/verify_email.dart';
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
      body:  pages[navigationProvider.currentIndex]
    );
        }
        
        }
        
       