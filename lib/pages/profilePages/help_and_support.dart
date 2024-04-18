import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
//custom app bar
import 'package:payezy/components/custom_container.dart'; // custom main body card
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/pages/profilePages/profile.dart';
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
                
               
                // TODO: Handle this case.
                ProfilePages.exploredocs => const ExploreDocs(),
                // TODO: Handle this case.
                ProfilePages.helpandsupport => const HelpAndSupport(),
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
                    print(profilePageProvider.profilePage);

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
         metrophobicText(query,size: 15.sp), 
         SizedBox(height: 2.h,),
         ElevatedButton(onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
         }, child: Text('Back'))
          ],
          );
  }
}
 

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
            child: metrophobicText("Issue type",color: lightBlueThemeColor,size: 18.sp)),
            SizedBox(height: 2.h,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: lightBlueThemeColor)
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: metrophobicText('Failed Transaction'),
                  ),
                ),
              ),
              SizedBox(width: 5.w,),
               Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: lightBlueThemeColor)
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: metrophobicText('Feedback/Bug'),
                ),
              ),
            ],
          ) , 
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(width: 28.w,),
              CustomButton(onPressed: (){
            profilePageProvider.setProfilePage(ProfilePages.helpandsupport);

              }, text: 'Cancel',size: 15.sp,color: lightBlueThemeColor,),
              SizedBox(width: 3.w,),
              CustomButton(onPressed: 
              (){
                profilePageProvider.setProfilePage(ProfilePages.exploredocs);
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

class ExploreDocs extends StatelessWidget {
  const ExploreDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}