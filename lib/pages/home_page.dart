import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart'; //custom app bar
import 'package:payezy/components/custom_container.dart'; // custom main body card
import 'package:payezy/pages/sendPages/enter_amount.dart';
import 'package:payezy/pages/sendPages/enter_details.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import '../../components/bottom_nav_bar.dart'; //custom bottom nav bar
import 'package:payezy/themes/colors.dart'; //colors

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return ChangeNotifierProvider(
      create: (context) => SendPageProvider(),
      child:
          Consumer<SendPageProvider>(builder: (context, sendPageProvider, child) {
return Scaffold(
   resizeToAvoidBottomInset: false, //to prevent the overflow when textfield is clicked
      backgroundColor: mainBackgroundColor,
      //appBar begins
      appBar:  const CustomAppBar(title: send,isVisible: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            CustomContainer(
              //custom container
              child: switch(sendPageProvider.sendPage){
                SendPage.enterAmount=>const EnterAmount(),
                SendPage.enterDetails=>const EnterDetails(),
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );

   
  
          }));
          }
}



 