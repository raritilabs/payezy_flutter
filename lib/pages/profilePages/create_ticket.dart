import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/components/custom_line.dart';
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

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
       padding: EdgeInsets.only(left: 5.w,right:5.w,top: 3.h,),
        child: CustomContainer(
         child: Column(
                mainAxisSize: MainAxisSize.min,
                 children:[ 
                   Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 1.h),
                  child: Align(
             alignment: Alignment.centerLeft,
             //title
             child: metrophobicText('Create a support ticket',size: 20.sp)),
                   ),
                  //horizontal line
                   customLine(100.w),
                   SizedBox(height: 3.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: 
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: metrophobicText("Issue type",color: greyFontThemeColor,size: 16.sp)),
                SizedBox(height: 2.h,),
              Column(
                children: [
                   CustomRadioButton(radiobuttontext: 'Failed Transaction',
                   gradientcolorone:profilePageProvider.chooseButton==ChooseButton.failedtransaction?radiobuttongradientcolorone:Colors.transparent,
                   gradientcolortwo:profilePageProvider.chooseButton==ChooseButton.failedtransaction?radiobuttongradientcolortwo:Colors.transparent,
                  bulletcolor: profilePageProvider.chooseButton==ChooseButton.failedtransaction?lightBlueThemeColor:Colors.transparent,
                  onTap: (){
                    profilePageProvider.setChooseButton(ChooseButton.failedtransaction);
                  },
                  ),
                  SizedBox(height: 5.w,),
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
                 // SizedBox(width: 28.w,),
                  Expanded(
                    child: CustomButton(onPressed: (){
                                    Navigator.pushNamed(context, '/helpandsupport');
                                    
                    }, text: 'Cancel',size: 15.sp,color: cancelButton,),
                  ),
                  SizedBox(width: 3.w,),
                  Expanded(
                    child: CustomButton(onPressed: 
                    (){
                      //if selected button is failed transaction, then navigate accordingly
                      if(profilePageProvider.chooseButton==ChooseButton.failedtransaction){
                    Navigator.pushNamed(context, '/failedtransaction');
                      }
                      else{
                                  profilePageProvider.setProfilePage(ProfilePages.feedbackorbug);
                                  Navigator.pushNamed(context, '/feedbackorbug');
                                    
                      }
                    }
                    , text: 'Proceed',color: lightBlueThemeColor,
                    size: 15.sp,
                                     
                             ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      ]),
    )));
  }
}
