import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/providers/error_provider.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/providers/login_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
        final getStartedProvider=Provider.of<GetStartedProvider>(context,listen: true);
        final loginProvider=Provider.of<LoginProvider>(context,listen: true);
        final errorProvider=Provider.of<ErrorProvider>(context,listen: true);//resets the sign in error
      

    return 
     Scaffold(
          resizeToAvoidBottomInset: false,

       appBar: const CustomAppBar(title: 'Profile', isVisible: true),
      backgroundColor: mainBackgroundColor,
    //   //bottomNavigationBar: const BottomNavBar(),
       body:
      FutureBuilder( 
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
          case ConnectionState.done:
return
        Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 10.w,
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
                                child: metrophobicText('KYC Verification', size: 15.sp),
                              ),
                              SizedBox(width: 1.w,),
                              Padding(
                          padding:  EdgeInsets.only(top:1.5.h,),
                         child: Image.asset('assets/inactiveProfileIcon.png',height: 2.5.h,),
                              )
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
                onPressed: (){},
                child: metrophobicText('Support', size: 16.sp)),
              SizedBox(height: 2.h),
              TextButton(
                 style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(40.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed:(){},
                child:metrophobicText('Privacy Policy', size: 16.sp)),
              SizedBox(height: 2.h),
              TextButton(
                  style:   ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                  minimumSize: MaterialStatePropertyAll(Size(38.w, 5.h)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                     padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: (){},
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
            
        );
        default:
              return const LinearProgressIndicator();
        
        }
        }
      ),
    );
  }
}
