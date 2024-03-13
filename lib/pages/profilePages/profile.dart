import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile', isVisible: true),
      backgroundColor: mainBackgroundColor,
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
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
                        'John Doe',
                        size: 18.sp,
                      ),
                      metrophobicText('john@gmail.com', color: lightGrey),
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
            metrophobicText('Support', size: 16.sp),
            SizedBox(height: 2.h),
            metrophobicText('Privacy Policy', size: 16.sp),
            SizedBox(height: 2.h),
            metrophobicText('Terms of Use', size: 16.sp),
            SizedBox(height: 3.h),
            metrophobicText('Log out', size: 16.sp),
          ],
        ),
      ),
    );
  }
}
