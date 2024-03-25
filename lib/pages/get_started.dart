import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/services/sign_in_with_facebook.dart';
import 'package:payezy/services/sign_in_with_google.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer' show log;

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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();  //disposes the email controller
  }

  @override
  Widget build(BuildContext context) {

    final getStartedProvider=Provider.of<GetStartedProvider>(context,listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents the bottom from coming up with the keyboard
        backgroundColor: mainBackgroundColor,  
        appBar: const CustomAppBar(title: getStarted, isVisible: false),  
        body:Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),  //side padding 5.w
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: spaceBetween(
                          metrophobicText(loginorsignup, size: 15.sp))),
                 // spaceBetween(
                  //   customTextField(email,'',
                  //      readOnly: false,
                  //       controller: _email,
                  //       onChanged: (value) => emailProvider.setEmail(value),
                  //       obscure: false,
                  //       textInputType: TextInputType.emailAddress),
                  // ),
                  SizedBox(height: 2.h,),
                  spaceBetween(CustomButton(
                    onPressed: () async{
                      Navigator.pushNamed(context, '/login');
                    },
                    text: 'Continue with Email/Password',
                    size: 16.sp,
                    color: white,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Center(
                      child: metrophobicText(or, size: 20.sp),
                    ),
                  ),
                  spaceBetween(
                    Center(
                      child: metrophobicText(loginquickly,
                          size: 15.sp, textAlign: TextAlign.justify),
                    ),
                  ),
                  spaceBetween(
                    CustomButton(
                      onPressed: ()  async{
                        try{ 
                       final user=await  signInWithGoogle();
                        
                         getStartedProvider.setUser(user.user?.displayName.toString(), user.user?.email);
                          Navigator.of(context).pushNamedAndRemoveUntil(mainScreen, (route) => false);
                          }
                        catch(e){
                          log('error is $e');
                        }
                       
                      },
                      text: google,
                      size: 16.sp,
                      leftAssetValue: 'assets/googleIcon.png',
                    ),
                  ),
                  spaceBetween(
                    CustomButton(
                        onPressed: () async{
                          try{ 
                       await FacebookAuth.instance.login(
                        permissions: ["public_profile","email"]
                       );
                       //  getStartedProvider.setUser(user.user?.displayName.toString(), user.user?.email);
                          Navigator.of(context).pushNamedAndRemoveUntil(mainScreen, (route) => false);
                          }
                        catch(e){
                          log('error is $e');
                        }
                          
                        },
                        text: meta,
                        size: 16.sp,
                        leftAssetValue: 'assets/metaIcon.png'),
                  ),
                  spaceBetween(
                    CustomButton(
                      onPressed: () {},
                      text: signinwith,
                      rightAssetValue: 'assets/XIcon.png',
                      size: 16.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: metrophobicText(
                       bySigning,
                       textAlign: TextAlign.justify,
                        size: 10.sp),
                  )
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
