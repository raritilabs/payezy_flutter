import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({super.key});

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  late final TextEditingController _youSend;
  
  @override
  void initState() {
    _youSend = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sendPageProvider =
        Provider.of<SendPageProvider>(context, listen: true);
    return Column(
      children: [
        ///Process payment via...
        Padding(
          padding:  EdgeInsets.only(left: 10.w, top: 0.2.h, bottom: 1.h),
          child: Align(
              alignment: Alignment.centerLeft,
              child: metrophobicText(paymentOptionsText,size: 10.sp,color:lightGrey)),
        ),
        //two buttons and lines

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //left decorative line
            Expanded(child: customLine()),
            //  Bank transfer button
            GestureDetector(
              
              onTap: () {},
              child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: lightBlueThemeColor,
                  ),
                  child:  Center(
                      child:metrophobicText(paymentOption1,
                      color: black,
                      size: 12.sp)
                  )),
            ),
            //Card Payment button
            GestureDetector(

              onTap: () {
              },
              child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    border: Border.all(color: lightBlueThemeColor),
                    color: Colors.transparent,
                  ),
                  child:  Center(
                      child: metrophobicText(creditcard,color: white,size: 12.sp),
                      )),
            ),
            //right decorative line
            Expanded(child: customLine()),
          ],
        ),
//space b/w
         SizedBox(
          height: 2.5.h,
        ),
  //Enter the amount of...
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w),
          child: metrophobicText(entertheamount,size: 12.sp),
        ),
          // space b/w
        //You send text field
        Padding(
            padding:EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h,bottom: 1.5.h),
            child: customTextField(
              youSend,
              'USD',
              label: '\00.00',
              controller: _youSend,
              onChanged: (value){
                sendPageProvider.setSendAmount(value);
                },
              textInputType: TextInputType.number,
              sideTextcolor: sendPageProvider.expanded?white:greyFontThemeColor,
             
            )),

        //Recipient gets...

        Padding(
          padding:EdgeInsets.only(left: 5.w, right: 5.w,),
          child: customTextField(
            recipientGets,
            'INR',
            label:sendPageProvider.expanded?sendPageProvider.youReceive.toString():'00.00',
             sideTextcolor: sendPageProvider.expanded?white:greyFontThemeColor,
             color: sendPageProvider.expanded?white:greyFontThemeColor,
            readOnly: true,
          ),
        ),
        Visibility(
          visible:sendPageProvider.expanded,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             SizedBox(height: 2.h,),
                metrophobicText('Charges Breakdown', color: lightGrey,size: 10.sp),
                SizedBox(height: 0.5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Best Price',size: 11.sp),
                    metrophobicText('\$1 @ 82.54 INR',size: 11.sp),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Platform Charges',size: 11.sp),
                    metrophobicText('--',size: 11.sp),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                metrophobicText('Net Transfer', color: lightGrey,size: 10.sp),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Total INR Transferred',size: 11.sp),
                    metrophobicText(sendPageProvider.youReceive.toString(),size: 11.sp)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Effective mid-market rate',size: 11.sp),
                    metrophobicText('--',size: 11.sp),
                  ],
                ),
               
              ],
            ),
          ),
        ),

        Padding(
          padding:
               EdgeInsets.only(bottom: 2.h, top:5.h , left: 5.w, right: 5.w),
          child: CustomButton(
            onPressed: () {
              sendPageProvider.setSendPage(SendPages.enterDetails);
            },
            text: proceed,
            size: 17.sp,
            color: white,
            rightAssetValue: 'assets/nextIcon.png',
          ),
        ),
      ],
    );
  }
}
