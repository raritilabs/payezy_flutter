import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_radio_button.dart';
import 'package:payezy/providers/profile_page_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  @override
  Widget build(BuildContext context) {
        final profilePageProvider=Provider.of<ProfilePageProvider>(context,listen: true);

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: metrophobicText("Issue type",color: greyFontThemeColor,size: 18.sp)),
            SizedBox(height: 2.h,),
          Row(
            children: [
               CustomRadioButton(radiobuttontext: 'Failed Transaction',
               gradientcolorone:profilePageProvider.chooseButton==ChooseButton.failedtransaction?radiobuttongradientcolorone:Colors.transparent,
               gradientcolortwo:profilePageProvider.chooseButton==ChooseButton.failedtransaction?radiobuttongradientcolortwo:Colors.transparent,
              bulletcolor: profilePageProvider.chooseButton==ChooseButton.failedtransaction?lightBlueThemeColor:Colors.transparent,
              onTap: (){
                profilePageProvider.setChooseButton(ChooseButton.failedtransaction);
              },
              ),
              SizedBox(width: 5.w,),
               CustomRadioButton(radiobuttontext: 'Feedback/Bug',
               gradientcolorone:profilePageProvider.chooseButton==ChooseButton.feedbackorbug?radiobuttongradientcolorone:Colors.transparent,
               gradientcolortwo:profilePageProvider.chooseButton==ChooseButton.feedbackorbug?radiobuttongradientcolortwo:Colors.transparent,
              bulletcolor: profilePageProvider.chooseButton==ChooseButton.feedbackorbug?lightBlueThemeColor:Colors.transparent,
              onTap: (){
               profilePageProvider.setChooseButton(ChooseButton.feedbackorbug);

              },),
            ],
          ) , 
          SizedBox(height: 5.h,),
          Row(
            children: [
              SizedBox(width: 28.w,),
              CustomButton(onPressed: (){
            profilePageProvider.setProfilePage(ProfilePages.helpandsupport);

              }, text: 'Cancel',size: 15.sp,color: lightBlueThemeColor,),
              SizedBox(width: 3.w,),
              CustomButton(onPressed: 
              (){
                //if selected button is failed transaction, then navigate accordingly
                if(profilePageProvider.chooseButton==ChooseButton.failedtransaction){
              profilePageProvider.setProfilePage(ProfilePages.failedtransaction);
                }
                else{
          profilePageProvider.setProfilePage(ProfilePages.feedbackorbug);

                }
              }
              , text: 'Proceed',color: lightBlueThemeColor,
              size: 15.sp,
             
                       ),
            ],
          ),
          SizedBox(height: 2.h,),
        ],
      ),
    );
  }
}
