import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/ticket_collection_failed_transaction.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/providers/profile_page_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
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
                    Navigator.pushNamed(context, '/createticket',);

                    }, text: 'Back',color: lightBlueThemeColor,size: 15.sp,),
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: CustomButton(
                      onPressed: (){
          
                     int epochTime = DateTime.now().millisecondsSinceEpoch;
                      addFailedTransactionTicket(num.parse(epochTime.toString()), _messageController.text, _orderIdController.text, "", "Submitted", "Failed Transaction");
                   Navigator.popAndPushNamed(context, '/mainscreen');

                    }, text: 'Create',color: lightBlueThemeColor,size: 15.sp,rightAssetValue: 'assets/nextIcon.png'),
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

