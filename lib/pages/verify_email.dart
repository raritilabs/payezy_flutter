import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: const CustomAppBar(title: "Verify Email"),
        body:Column(
        children:[ Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        metrophobicText("We've sent you an email verification. Please verify your account."),
                        SizedBox(height: 2.h,),
                        metrophobicText("If you haven't recieved a verification email, press the button below"),
                       SizedBox(height: 2.h,),

                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(onPressed: ()async{
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushNamedAndRemoveUntil(getStartedPage, (route) => false);
                              }, text:"Back",size: 9.sp,),
                            ),
                            SizedBox(width: 2.w,),
                            Expanded(
                              child: CustomButton(
                                onPressed: () async {
                                 final user = FirebaseAuth.instance.currentUser;
                                await user?.sendEmailVerification();       
                                  },
                                      
                                text: "Send Email Verification",
                                size: 9.sp,
                              ),
                            ),
                          ],
                        ),
            
                       
                      ],
                    ),
                  )]),
      );
            }
          }