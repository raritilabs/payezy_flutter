import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/pages/main_screen.dart';
// ignore: unused_import
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //initializing firebase
    return FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;              
                  if (user != null)  {
                    return const MainScreen();
                  
                  } else {
                    //user logged out
                  
                  return const GetStarted();    
                  }
                default:
                return const GetStarted();
              }

            });
  }
}
