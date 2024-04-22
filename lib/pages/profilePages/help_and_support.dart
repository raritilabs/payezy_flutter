import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
//custom app bar
import 'package:payezy/components/custom_container.dart'; // custom main body card
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/components/custom_radio_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/ticket_collection_failed_transaction.dart';
import 'package:payezy/functions/ticket_collection_feedback_or_bug.dart';
import 'package:payezy/pages/profilePages/create_ticket.dart';
import 'package:payezy/pages/profilePages/feedback_or_bug.dart';
import 'package:payezy/pages/transferPages/fetch_data.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/providers/profile_page_provider.dart';
import 'package:payezy/services/routes.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:payezy/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart'; //colors

class HelpAndSupportHomePage extends StatefulWidget {
  const HelpAndSupportHomePage({super.key});

  @override
  State<HelpAndSupportHomePage> createState() => _HelpAndSupportHomePageState();
}


class _HelpAndSupportHomePageState extends State<HelpAndSupportHomePage> {

  @override
  Widget build(BuildContext context) {

   
     return ChangeNotifierProvider(
      create: (context) => ProfilePageProvider(),
      child:
          Consumer<ProfilePageProvider>(builder: (context, profilePageProvider, child) {
            
return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: true,

  ),
      backgroundColor: mainBackgroundColor,
            body: Padding(
       padding: EdgeInsets.only(left: 5.w,right:5.w,top: 3.h,),
        child: ListView(
          children: [
            CustomContainer(
              //custom container
              child:Column(
      children:[ 
        Padding(
          padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 1.h),
          child: Align(
  alignment: Alignment.centerLeft,
  //title
  child: metrophobicText('Help & Support',size: 20.sp)),
        ),
//horizontal line
        customLine(100.w),
        SizedBox(height: 3.h,),
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: 3.w),
         child: switch(profilePageProvider.profilePage){
                ProfilePages.createticket=>const CreateTicket(),
                ProfilePages.failedtransaction => const FailedTransaction(),
                ProfilePages.helpandsupport => const HelpAndSupport(),
                     ProfilePages.feedbackorbug => const FeedbackOrBug(),
              },
            ),
          ],
        ),
      ),
    ])));  
          }));
          }
}

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});
  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
        final Uri exploreDocsUri=Uri.parse('https://docs.payezy.io/');
    final profilePageProvider=Provider.of<ProfilePageProvider>(context,listen: true);
    return Column(
          children: [
            //Create ticket button
         GestureDetector(
          onTap: (){
                  
                  profilePageProvider.setProfilePage(ProfilePages.createticket);         

          },
           child: Container(
             width: double.infinity,
             decoration: BoxDecoration(border: Border.all(color: lightBlueThemeColor,),
             borderRadius: BorderRadius.circular(10),
             ),
             child: Padding(
               padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
               child: metrophobicText('Create a support ticket',size: 20.sp,textAlign: TextAlign.left,color: lightBlueThemeColor),
             ),
           ),
         ),
         //space b/w
         SizedBox(height: 2.h,),
           //Explore Docs
           GestureDetector(
            onTap: (){
                
                  launchUrl(exploreDocsUri,
                  mode: LaunchMode.inAppWebView);
                
            },
             child: Container(
               width: double.infinity,
               decoration: BoxDecoration(border: Border.all(color: lightBlueThemeColor,),
               borderRadius: BorderRadius.circular(10),
               ),
               child: Padding(
                 padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                 child: metrophobicText('Explore Docs',size: 20.sp,textAlign: TextAlign.left,color: lightBlueThemeColor),
               ),
             ),
           ),
 //space b/w
 SizedBox(height: 2.h,),             
         //for any queries 
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: 3.w),
           child: metrophobicText(query,size: 15.sp),
         ),
         Align(
          alignment: Alignment.centerLeft,
           child: TextButton(
            onPressed: (){
             launchUrl(Uri(scheme: 'mailto',
             path: "support@rariti.io",
             queryParameters: {
              'subject':"support",
             }));
            },
            child: metrophobicText('support@rariti.io',color: yellow, size: 15.sp),
            ),
         ), 
         SizedBox(height: 2.h,),
         CustomButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (route) => false);

         }, text: 'Back'),
         SizedBox(height: 2.h,),
          ],
          
          );
  }
}
 


class FailedTransaction extends StatefulWidget {
  const FailedTransaction({super.key});

  @override
  State<FailedTransaction> createState() => _FailedTransactionState();
}

class _FailedTransactionState extends State<FailedTransaction> {
   late final TextEditingController _orderIdController;
   late final TextEditingController _messageController;

  @override
  void initState() {
    _orderIdController=TextEditingController();
    _messageController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
_orderIdController.dispose();
_messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final profilePageProvider=Provider.of<ProfilePageProvider>(context,listen: true);
    final fetchDataProvider=Provider.of<FetchDataProvider>(context,listen: true);

    return Column(
      children: [
        customTextField('OrderID',
        controller: _orderIdController,
        label: profilePageProvider.orderId
        ),
        SizedBox(height: 2.h,),
        customTextField('Message',
        controller:_messageController,
        ),  
                SizedBox(height: 2.h,),

        Row(
          children: [
            Expanded(
              child: CustomButton(onPressed: (){
                // profilePageProvider.setProfilePage(ProfilePages.createticket);
               fetchDataProvider.setTransferPage(TransferPages.transferhistory);
              
              }, text: 'Back',color: lightBlueThemeColor,size: 15.sp,),
            ),
            SizedBox(width: 5.w,),
            Expanded(
              child: CustomButton(
                onPressed: (){

               int epochTime = DateTime.now().millisecondsSinceEpoch;
                addFailedTransactionTicket(num.parse(epochTime.toString()), _messageController.text, _orderIdController.text, "", "Submitted", "Failed Transaction");
              }, text: 'Create',color: lightBlueThemeColor,size: 15.sp,rightAssetValue: 'assets/nextIcon.png'),
            ),
          ],
        ),
        SizedBox(height: 2.h,),
      ],
    );
  }
}

