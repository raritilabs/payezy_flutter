import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart'; //custom app bar
import 'package:payezy/components/custom_container.dart'; // custom main body card
import 'package:payezy/pages/sendPages/enter_amount.dart';
import 'package:payezy/pages/sendPages/enter_details.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:payezy/themes/colors.dart'; //colors

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}


class _SendPageState extends State<SendPage> {

  @override
  Widget build(BuildContext context) {

    
     return ChangeNotifierProvider(
      create: (context) => SendPageProvider(),
      child:
          Consumer<SendPageProvider>(builder: (context, sendPageProvider, child) {
            
return Scaffold(
  
  //resizeToAvoidBottomInset: false, //to prevent the overflow when textfield is clicked
      backgroundColor: mainBackgroundColor,
      //appBar begins
      appBar:  const CustomAppBar(title: send,isVisible: true,),
      body: Padding(
       padding: EdgeInsets.only(left: 5.w,right:5.w,top: 3.h,),
        child: ListView(
          children: [
            CustomContainer(
              //custom container
              child: switch(sendPageProvider.sendPage){
                SendPages.enterAmount=>const EnterAmount(),
                SendPages.enterDetails=>const EnterDetails(),
              },
            ),
          ],
        ),
      ),
    );  
          }));
          }
}



 