import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/functions/enter_user_data.dart';
import 'package:payezy/providers/error_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/providers/login_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/services/sign_in_with_facebook.dart';
import 'package:payezy/services/sign_in_with_google.dart';
import 'package:payezy/services/sign_in_with_twitter.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController(); //controls the email text field
   // Provider.of<GetStartedProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose(); //disposes the email controller
  }

  @override
  Widget build(BuildContext context) {
//calling getStartedProvider(state manaagement)
    final getStartedProvider =
        Provider.of<GetStartedProvider>(context, listen: true);
//calling login provider
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
//calling error provider to set errors
        final errorProvider = Provider.of<ErrorProvider>(context, listen: true);

    return Scaffold(
//prevents the bottom popping up with the keyboard
        resizeToAvoidBottomInset: false,
        backgroundColor: mainBackgroundColor,
        appBar: const CustomAppBar(title: getStarted, isVisible: false),
        body: Padding(
//side padding 5.w
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SingleChildScrollView(
//main column              
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
//login/signup title
                      child: spaceBetween(
                          metrophobicText(loginorsignup, size: 15.sp))),
//gap b/w
                  SizedBox(
                    height: 2.h,
                  ),
//email/password button
                  spaceBetween(CustomButton(
                    onPressed: () async {
                      loginProvider.setLoginType(LoginType.emailPassword);
                      Navigator.pushNamed(context, '/login');
                    },
                    text: 'Continue with Email/Password',
                    size: 14.sp,
                    color: white,
                  )),
//or text

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Center(
                      child: metrophobicText(or, size: 20.sp),
                    ),
                  ),
//login quickly text...
//                  
                  spaceBetween(
                    Center(
                      child: metrophobicText(loginquickly,
                          size: 15.sp, textAlign: TextAlign.justify),
                    ),
                  ),

 //google login button and function

                  spaceBetween(
                    CustomButton(
                      onPressed: () async {
                        try {
//setting the logintype to google
                          loginProvider.setLoginType(LoginType.google);
//signing in with google
                          final userCredential = await signInWithGoogle();

//fetching the display name and email from usercredentials
//
                          getStartedProvider.setUser(
                              userCredential.user?.displayName.toString(),
                              userCredential.user?.email);
//adding the user data to firebase
                          addUserData(
                              'not initialised',
                              userCredential.user!.toString(),
                              userCredential.user!.displayName.toString(),
                              '',
                              '',
                              '',
                              );
//navigating to main page after sign in                              
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              mainScreen, (route) => false);
//on firebaseexception
                        } on FirebaseAuthException catch (e) {
//exception handling                
                          if (e.code ==
                              'account-exists-with-different-credential') {
                            // The account already exists with a different credential
//fetch the error-causing email and credential
                            String? email = e.email;
                            AuthCredential? pendingCredential = e.credential;
//logging the error
                            errorProvider.setError('User account exists with a different credential. Please try logging in by using any other provider.');
                            errorProvider.setErrorVisibility();
                           
//querying from firebase for the provider used to sign in with this email         
                            //  QuerySnapshot query = await FirebaseFirestore
                            //      .instance
                            //      .collection('userData')
                            //      .where("email", isEqualTo: email)
                            //      .get();
                            //  if (query.docs.isNotEmpty) {
                            //    // Get the data from the first document and cast it to Map<String, dynamic>?
                            //    Map<String, dynamic>? userData = query.docs.first
                            //        .data() as Map<String, dynamic>?;

                            // //   // Check if userData is not null and email is associated with facebook.com
                            //    if (userData != null &&
                            //        userData['providerId'] == 'facebook.com') {
                            //      final userCredential =
                            //          await signInWithFacebook();
                            //      await userCredential!.user
                            //          ?.linkWithCredential(pendingCredential!);
                            //      Navigator.of(context).pushNamedAndRemoveUntil(
                            //          mainScreen, (route) => false);
                            //    }
                            //    if (userData != null &&
                            //        userData['providerId'] == 'twitter.com') {
                            //      final userCredential = await signInWithTwitter();
                            //      await userCredential.user
                            //          ?.linkWithCredential(pendingCredential!);
                            //      Navigator.of(context).pushNamedAndRemoveUntil(
                            //          mainScreen, (route) => false);
                            //   }
                            // }
                          }
                        } catch (e) {
                          log(e.toString());
                          errorProvider.setError('error is $e');
                          errorProvider.setErrorVisibility();
                        }
                      },
                      text: google,
                      size: 16.sp,
                      leftAssetValue: 'assets/googleIcon.png',
                    ),
                  ),
                  //facebook login
                  spaceBetween(
                    CustomButton(
                        onPressed: () async {
                          try {
                            loginProvider.setLoginType(LoginType.facebook);
                            final user = await signInWithFacebook();                  
                            getStartedProvider.setUser(
                                user!.user?.displayName.toString(),
                                user.user?.email.toString());
                            addUserData(
                                'not initialised',
                                user.user!.email.toString(),
                                user.user!.displayName.toString(),
                                '',
                                '',
                                '',
                                );
                  
                            getStartedProvider.setUserCredentials(user);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                mainScreen, (route) => false);
                          } on FirebaseAuthException catch (e) {
                  //exception handling                
                        if (e.code ==
                            'account-exists-with-different-credential') {
                          // The account already exists with a different credential
                  //fetch the error-causing email and credential
                          String? email = e.email;
                          AuthCredential? pendingCredential = e.credential;
                  //logging the error
                          errorProvider.setError('User account exists with a different credential. Please try logging in by using any other provider.');
                          errorProvider.setErrorVisibility();
                         if(loginProvider.loginType==LoginType.x) {
                             final userCredential=await signInWithTwitter();
                             userCredential.user?.linkWithCredential(pendingCredential!);
                            }
                        }
                      }catch (e) {
                            errorProvider.setError('error is $e');
                            errorProvider.setErrorVisibility();
                          }
                        },
                        text: meta,
                        size: 16.sp,
                        leftAssetValue: 'assets/metaIcon.png'),
                  ),

//X login button
                  spaceBetween(
                    CustomButton(
                      onPressed: () async {
                        loginProvider.setLoginType(LoginType.x);

                        try {
                          UserCredential userCredential =
                              await signInWithTwitter();

                          addUserData(
                              'not initialised',
                              userCredential.user!.email.toString(),
                              userCredential.user!.displayName.toString(),
                              '',
                              '',
                              '',
                              );
                          getStartedProvider.setUser(
                              userCredential.user?.displayName.toString(),
                              userCredential.user?.email.toString());
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              mainScreen, (route) => false);
                          getStartedProvider.setUserCredentials(userCredential);
                        } on FirebaseAuthException catch (e) {
//exception handling                
                          if (e.code ==
                              'account-exists-with-different-credential') {
                            // The account already exists with a different credential
//fetch the error-causing email and credential
                            String? email = e.email;
                            AuthCredential? pendingCredential = e.credential;
//setting the error
                            errorProvider.setError('User account exists with a different credential. Please try logging in by using any other provider.');
                            errorProvider.setErrorVisibility();

                          if(loginProvider.loginType==LoginType.x) {
                             final userCredential=await signInWithTwitter();
                             userCredential.user?.linkWithCredential(pendingCredential!);
                            }

//querying from firebase for the provider used to sign in with this email      
                            }
                          
                        } catch (e) {
                          errorProvider.setError('error is $e');
                          errorProvider.setErrorVisibility();
                        }
                      },
                      text: signinwith,
                      rightAssetValue: 'assets/XIcon.png',
                      size: 16.sp,
                    ),
                  ),
                  Visibility(
                    visible: errorProvider.errorVisibility,
                    child: spaceBetween(
                      metrophobicText(errorProvider.error,color: Colors.red),
                    ),
                  ),

 //terms and privacy policy
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: metrophobicText(bySigning,
                        textAlign: TextAlign.justify, size: 10.sp),
                  ),
                ],
              ),
            )));
  }
}

Widget spaceBetween(child) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: child,
  );
}
