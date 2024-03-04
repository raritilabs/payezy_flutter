// ignore: unused_import
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _password;

  @override
  void initState() {
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<GetStartedProvider>(context);
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: FutureBuilder(
        future:Firebase.initializeApp(
                        options: DefaultFirebaseOptions.currentPlatform,
                      ),
        builder: (context,snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
             return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //email field
                customTextField(email, emailProvider.email, null, null, true,
                    TextInputType.emailAddress),
          
                const SizedBox(
                  height: 15,
                ),
                customTextField(
                    password,
                    '',
                    _password,
                    (value) => emailProvider.setPassword(value),
                    false, //readonly value
                    TextInputType.text,
                    true),
          
                const SizedBox(
                  height: 15,
                ),
                 customTextField(
                    'Confirm Password',
                    '',
                    _password,
                   null,
                    false, //readonly value
                    TextInputType.text,
                    true),
          
                const SizedBox(
                  height: 15,
                ),
          
                CustomButton(
                    onPressed: () async{
                     
                      final user=emailProvider.email;
                      final password=emailProvider.password;
                      final userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user, password: password);
                      print(userCredential);
                    },
                    text: signup,
                    size: 16,
                    color: white),
                    
                TextButton(
                  onPressed: () {
                 Navigator.pushNamed(context, '/homepage');

                  },
                  child: const Text('Already Registered? Login here'),
                  
                ),
                
              ],
            ),
          );
          default:return LinearProgressIndicator();
          }
          
        }
      ),
    );
  }
}
