import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/providers/error_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/providers/login_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Uri privacyUri=Uri.parse('https://docs.payezy.io/platform/privacy-policy');
    final Uri termsUri=Uri.parse('https://docs.payezy.io/platform/terms-of-use');
        final getStartedProvider=Provider.of<GetStartedProvider>(context,listen: true);
        final loginProvider=Provider.of<LoginProvider>(context,listen: true);
        final errorProvider=Provider.of<ErrorProvider>(context,listen: true);//resets the sign in error
      

    return 
     Scaffold(
          resizeToAvoidBottomInset: false,

       appBar: const CustomAppBar(title: 'Profile', isVisible: true),
      backgroundColor: mainBackgroundColor,
       body:Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300.0),
                    child:Image.network(getStartedProvider.photo.isEmpty==true?'https://cdn1.iconfinder.com/data/icons/mix-color-3/502/Untitled-7-1024.png':getStartedProvider.photo,width: 10.h,), 
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        metrophobicText(
                          getStartedProvider.user,
                          size: 18.sp,
                        ),
                        metrophobicText(getStartedProvider.useremail, color: lightGrey),
                      ],
                    ),
                  )
                ],
              ),
              //-----------------------Top Section------------------------------------------------//
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top:1.5.h,left: 2.w,),
                                child: metrophobicText( 'KYC Verification', size: 15.sp),
                              ),
                             
                             
                            ],
                          ),
                          Row(
                            children: [
                              
                              Padding(
                                padding:  EdgeInsets.only(top:1.h,left: 2.w,bottom: 1.5.h),
                                child: metrophobicText('Not Verified',
                                    size: 12.sp, color: lightGrey),
                              ),
                          Padding(
                          padding:  EdgeInsets.only(top:1.h,bottom: 1.5.h),
                            child: Image.asset('assets/kycPendingIcon.png',height: 2.5.h,),
                          ),
                          SizedBox(width: 1.h,)
           
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(
                     width: 3.w,
                   ),
                   Expanded(
                     child: CustomContainer(
                       child: Padding(
                         padding:  EdgeInsets.symmetric(vertical: 3.h,),
                         child: metrophobicText('Start KYC',
                             size: 16.sp, color: lightBlueThemeColor,textAlign: TextAlign.center),
                       ),
                     ),
                   ),
                ],
              ),
              //-------------------------second section------------------------------------//
              SizedBox(height: 5.h),
              TextButton(
                 style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(26.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: (){
Navigator.pushNamedAndRemoveUntil(context, '/helpandsupport', (route) => false);
                },
                child: metrophobicText('Support', size: 16.sp)),
              SizedBox(height: 2.h),
              TextButton(
                 style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(40.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed:(){
                  launchUrl(privacyUri,
                  mode: LaunchMode.inAppWebView);
                },
                child:metrophobicText('Privacy Policy', size: 16.sp)),
              SizedBox(height: 2.h),
              TextButton(
                  style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(38.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: (){
                  launchUrl(termsUri,
                  mode: LaunchMode.inAppWebView,
                  );
                },
                child: metrophobicText('Terms of Use', size: 16.sp)),
              SizedBox(height: 2.h),
              TextButton(
                 style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(25.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: () async{ 
                  errorProvider.reset();
                switch(loginProvider.loginType){

                  case LoginType.emailPassword:
                      await FirebaseAuth.instance.signOut(); 
                  case LoginType.facebook:
            await  FacebookAuth.instance.logOut();             
                  case LoginType.google:
                await GoogleSignIn().signOut();
                  case LoginType.x:
               FirebaseAuth.instance.signOut();
                }
                 getStartedProvider.resetUser();     
              Navigator.of(context).pushNamedAndRemoveUntil(getStartedPage, (route) => false); },
              child: metrophobicText('Log out', size: 16.sp)),
            ],
          )
            
        ));
        
        }
}