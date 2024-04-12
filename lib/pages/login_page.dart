// ignore: unused_import
import 'dart:math';
import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/providers/error_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late final TextEditingController _password;
  late final TextEditingController _email;

  @override
  void initState() {
    _password = TextEditingController();
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getStartedProvider =
        Provider.of<GetStartedProvider>(context, listen: false);
    final errorProvider =
        Provider.of<ErrorProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: 'Login'),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //email field
                      customTextField(email, '',
                          controller: _email,
                          readOnly: true,
                          //  onChanged: (value) => emailProvider.(value),
                          textInputType: TextInputType.emailAddress),
                      SizedBox(
                        height: 1.h,
                      ),
                      customTextField(password, '',
                          controller: _password,
                          //   onChanged: (value) => emailProvider.setPassword(value),
                          readOnly: false, //readonly value
                          textInputType: TextInputType.text,
                          obscure: true),

                      SizedBox(
                        height: 8.h,
                      ),

                      CustomButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                         devtools.log('email is $email and password is $password');

                          try {

                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            getStartedProvider.setUser(
                                userCredential.user?.displayName.toString(),
                                userCredential.user?.email);
                            // getStartedProvider.setUserCredentials(userCredential);

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                mainScreen, (route) => false);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-credential') {
                              errorProvider.setError('Invalid credential');
                              errorProvider.setErrorVisibility();
                            } else if (e.code ==
                                'account-exists-with-different-credential') {
                              // The account already exists with a different credential
                              String? email = e.email;
                              AuthCredential? pendingCredential = e.credential;
                             errorProvider.setError(
                                  'User account exists with a different credential. Please try logging in by using any other provider.');
                              errorProvider.setErrorVisibility();
                               if (pendingCredential?.signInMethod ==
                                  'twitter.com') {
                                //  getStartedProvider.setIsVisible();
                                UserCredential userCredential =
                                    getStartedProvider.userCredentials;
                                if (userCredential.user!.email == email) {
                                  await getStartedProvider.userCredentials.user
                                      ?.linkWithCredential(pendingCredential!);
                                }
                              }
                            }
                          } catch (e) {
                            devtools.log('error is $e');
                            errorProvider.setError('error is $e');
                            errorProvider.setErrorVisibility();
                          }
                        },
                        text: login,
                        size: 18.sp,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

  Visibility(
    visible: errorProvider.errorVisibility,
    child: SizedBox(
                          height: 2.h,
                        child: metrophobicText(errorProvider.error,color: Colors.red),),
  ),

                      
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              signupPage, (route) => false);
                        },
                        child: metrophobicText('New User? Sign Up',
                            color: lightBlueThemeColor),
                      ),
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          }),
    );
  }
}
