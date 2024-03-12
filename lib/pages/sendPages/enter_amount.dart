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
          padding:  EdgeInsets.only(left: 10.w, top: 1.h, bottom: 2.h),
          child: Align(
              alignment: Alignment.centerLeft,
              child: subtitleText(paymentOptionsText)),
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
                  width: 150,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: lightBlueThemeColor,
                  ),
                  child: const Center(
                      child: Text(
                    paymentOption1,
                    style: TextStyle(color: black),
                  ))),
            ),
            //Card Payment button
            GestureDetector(
              onTap: () {},
              child: Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    border: Border.all(color: lightBlueThemeColor),
                    color: Colors.transparent,
                  ),
                  child: const Center(
                      child: Text(creditcard, style: TextStyle(color: white)))),
            ),
            //right decorative line
            Expanded(child: customLine()),
          ],
        ),

        const SizedBox(
          height: 10,
        ),
        //Enter the amount of...
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: titleText(entertheamount),
        ),
        const SizedBox(
          height: 5,
        ), // space b/w
        //You send text field
        Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 10),
            child: customTextField(
              youSend,
              label: '\$',
              controller: _youSend,
              onChanged: (value)=>sendPageProvider.setSendAmount(value),
              textInputType: TextInputType.number
            )),

        //Recipient gets...

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: customTextField(
            recipientGets,
            label: sendPageProvider.youReceive.toString(),
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
                metrophobicText('Charges Breakdown', color: lightGrey),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Best Price'),
                    metrophobicText('\$1 @ 82.54 INR'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Platform Charges'),
                    metrophobicText('--')
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                metrophobicText('Net Transfer', color: lightGrey),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Total INR Transferred'),
                    metrophobicText(sendPageProvider.youReceive.toString())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    metrophobicText('Effective mid-market rate'),
                    metrophobicText('--')
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, top: 0, left: 15, right: 15),
          child: CustomButton(
            onPressed: () {
              sendPageProvider.setSendPage(SendPage.enterDetails);
            },
            text: proceed,
            size: 22,
            color: white,
            rightAssetValue: 'assets/nextIcon.png',
          ),
        ),
      ],
    );
  }
}
