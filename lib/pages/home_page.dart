import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/pages/main_screen.dart';
import 'package:payezy/pages/verify_email.dart';
import 'dart:developer' show log;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    if (user.emailVerified) {
                      log('Email is verified');
                    } else {
                      return const VerifyEmail();
                    }
                  } else {
return const GetStarted();                 }
                  return const MainScreen();
                default:
                  return const CircularProgressIndicator();
              }
            });
  }
}
