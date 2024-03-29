// ignore: unused_import
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // late final TextEditingController _password;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<GetStartedProvider>(
      context,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false, //prevents overflow when keyboard pops up
      backgroundColor: mainBackgroundColor, //imported from colors.dart
      appBar: const CustomAppBar(title: 'Sign Up'), //appbar with notification icon disabled
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 13.h),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          customTextField('Full Name', '',
                            controller: _name,
                            label: emailProvider.email,
                            readOnly: false,
                            textInputType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                          emailProvider.setName(value);
                        }),

                        SizedBox(
                          height: 3.h,
                        ),
                        //email field
                        customTextField(email, '',
                            controller: _email,
                            label: emailProvider.email,
                            readOnly: false,
                            textInputType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                          emailProvider.setEmail(value);
                        }),

                        SizedBox(
                          height: 3.h,
                        ),
                        customTextField(password, '', controller: _password,
                        enableSuggestions: false,
                            onFieldSubmitted: (value) {
                          emailProvider.setPassword(value);
                        },
                            readOnly: false, //readonly value
                            textInputType: TextInputType.text,
                            obscure: true),

                        SizedBox(
                          height: 3.h,
                        ),
                        customTextField('Confirm Password', '',
                            controller: _confirmPassword,
                            onFieldSubmitted: (value) {
                          emailProvider.setConfirmPassword(value);
                        },
                            readOnly: false, //readonly value
                            textInputType: TextInputType.text,
                            obscure: true),

                        SizedBox(
                          height: 3.h,
                        ),
                        metrophobicText(
                            emailProvider.wrongPassword
                                ? "Passwords do not match"
                                : '',
                            color: Colors.red),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (_password.text != _confirmPassword.text) {
                              log('password is ${emailProvider.password}');
                              log(
                                  'confirmpassword is ${emailProvider.confirmPassword}');

                              emailProvider.setWrongPasswordValidation();
                            } else {
                              final displayName=_name.text;

                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                user?.updateDisplayName(displayName);
                                await user?.sendEmailVerification();
                                Navigator.of(context).pushNamed(verifyEmail);
                    
                              } on FirebaseAuthException catch (e) {
                                 if (e.code == 'weak-password') {
                                   log('Weak Password');
                                 } 
                                  else if (e.code == 'email-already-in-use') 
                                  {
                                    log("Email is already in use by another account");
                                  }
                                   else if (e.code == 'invalid-email') 
                                  {
                                    log("Email is already in use by another account");
                                  }
                                  else{ 
                                  log("Invalid email entered");

                                  }
                              } 
              
                            }
                          },
                          text: signup,
                          size: 18.sp,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/getstarted', (route) => false);
                          },
                          child: metrophobicText(
                              'Already have an account? Login here',
                              color: lightBlueThemeColor),
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return const LinearProgressIndicator();
            }
          }),
    );
  }
}
