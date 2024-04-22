import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/fetch_exchange_rate.dart';
import 'package:payezy/functions/get_inr_treasury_balance.dart';
import 'package:payezy/functions/truncate_to_decimal.dart';
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
  late final TextEditingController _youSend; //fetches the send amount from user
  double maxLimit = 2000; //change it according to the maximum limit
  double maxAllowed = 2000; //to store the inr treasury balance
  double exchangeRate = 0; //initialising
  double maximumAllowed = 0; //initialising

  @override
  void initState() {
    _youSend = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _youSend.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    maxAllowed = await getInrTreasuryBalance();
    exchangeRate = await fetchExchangeRate();
    super.setState(() {}); // to update widget data
  }

  double calculatemaxAllowed() {
    if (exchangeRate != 0) {
      maximumAllowed = maxAllowed / exchangeRate;
      if (maximumAllowed < maxLimit) {
        return maximumAllowed;
      } else {
        maximumAllowed = maxLimit;
        return maximumAllowed;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    
    final sendPageProvider =
        Provider.of<SendPageProvider>(context, listen: true);

    return Column(
      children: [
        ///Process payment via...
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 0.2.h, bottom: 1.h),
          child: Align(
              alignment: Alignment.centerLeft,
              child: metrophobicText(paymentOptionsText,
                  size: 10.sp, color: lightGrey)),
        ),
//two buttons and lines

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//left decorative line
            Expanded(child: customLine(18)),
//  Bank transfer button
            GestureDetector(
              onTap: () {
                sendPageProvider.setBankIsSelected();
              },
              child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    border: Border.all(color: lightBlueThemeColor),
                    color: sendPageProvider.bankIsSelected
                        ? lightBlueThemeColor
                        : Colors.transparent,
                  ),
                  child: Center(
                      child: metrophobicText(paymentOption1,
                          color:
                              sendPageProvider.bankIsSelected ? black : white,
                          size: 12.sp))),
            ),
//Card Payment button
            GestureDetector(
              onTap: () {
                sendPageProvider.setCardIsSelected();
              },
              child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    border: Border.all(color: lightBlueThemeColor),
                    color: sendPageProvider.cardIsSelected
                        ? lightBlueThemeColor
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: metrophobicText(paymentOption2,
                        color: sendPageProvider.cardIsSelected ? black : white,
                        size: 12.sp),
                  )),
            ),
            //right decorative line
            Expanded(child: customLine(18)),
          ],
        ),
        //space b/w button and enter the amount..
        SizedBox(
          height: 2.5.h,
        ),
        //Enter the amount of...
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: metrophobicText(entertheamount, size: 12.sp),
        ),
        // space b/w
        //You send text field
        Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
              top: 2.h,
            ),
            child: customTextField(
              youSend,
              sideText1: 'USD',
              label: '00.00',
              infoText: calculatemaxAllowed() == 0
                  ? ''
                  : 'Maximum allowed: \$${(maximumAllowed).toStringAsFixed(0)}',
              infoTextVisibility: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              controller: _youSend,
              sidetextVisibility: true,
              onChanged: (youSendValue) {
              
                sendPageProvider.setExchangeRate(exchangeRate);
                //setting the value of sendAmt in SendPageProvider
                sendPageProvider.setSendAmount(youSendValue ?? 0);
              },
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              sideTextcolor:
                  sendPageProvider.expanded ? white : greyFontThemeColor,
            )),
//exchange rate
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Exchange Rate (Best Price)',
                  color: lightBlueThemeColor, size: 12.sp),
              exchangeRate > 0
                  ? metrophobicText(
                      '\$${(exchangeRate).truncateToDecimalPlaces(2)}',//shows two decimal places
                      size: 12.sp,
                      color: lightBlueThemeColor)
                  : SizedBox(
                      height: 3.h,
                      width: 3.h,
                      child: const CircularProgressIndicator( //loading indicator
                        color: lightBlueThemeColor,
                      )),
            ],
          ),
        ),

        //Recipient gets...

        Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          child: customTextField(
            recipientGets,
            sideText1: 'INR',
            sidetextVisibility: true,
            //if in expanded view, check card/bank and show the details accordingly
            label:sendPageProvider.bankIsSelected
                    ? sendPageProvider.youReceiveBank.toString()
                    : sendPageProvider.youReceiveCard.toString(),
                
            sideTextcolor:
                sendPageProvider.expanded ? white : greyFontThemeColor,
            color: sendPageProvider.expanded ? white : greyFontThemeColor,
            readOnly: true,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        metrophobicText(
            sendPageProvider.noValueValidationMessage
                ? "Please enter a valid amount of USD to continue"
                : '',
            color: Colors.red,
            size: 11.sp),
       
        Visibility(
          visible: sendPageProvider.youSend!=0?true:false,
          child: ExpansionTile(title:metrophobicText('Transaction Summary',size: 12.sp),
            initiallyExpanded: sendPageProvider.expanded,
            iconColor: lightBlueThemeColor,
            collapsedIconColor: lightBlueThemeColor,
                onExpansionChanged: (bool value){
          sendPageProvider.setExpanded(value);
                } 
          
          
          ),
        ),

        Visibility(
            visible: sendPageProvider.expanded,
            child: sendPageProvider.bankIsSelected
                ? bankTransfer()
                : creditCard()),

        Padding(
          padding:
              EdgeInsets.only(bottom: 2.h, top: 4.h, left: 5.w, right: 5.w),
          child: CustomButton(
            onPressed: () {
              if (sendPageProvider.youSend == 0.0) {
                sendPageProvider.setnoValueValidationMessage(); //notifies no value is types
              } else if (sendPageProvider.youSend > maxLimit) {
                sendPageProvider.setmaxValueValidationMessage(); // notifies maximum limit has reached
              } else {
                sendPageProvider.setSendPage(SendPages.enterDetails);
                      

              }
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

  Widget bankTransfer() {
    final sendPageProvider =
        Provider.of<SendPageProvider>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          metrophobicText('Charges Breakdown', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 0.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Bank Transfer Charges(0.8%)', size: 11.sp),
              metrophobicText(
                  sendPageProvider.bankTransferCharge.toStringAsFixed(2),
                  size: 11.sp),
            ],
          ),
          metrophobicText('(Capped at \$5)', size: 10.sp),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Payezy Platform Fees', size: 11.sp),
              metrophobicText('\$0.00', size: 11.sp),
              //please substract once platform fees is added
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Total Charges',
                  size: 11.sp, color: lightBlueThemeColor),
              metrophobicText(
                  '\$${sendPageProvider.totalCharges.toStringAsFixed(2)}',
                  size: 11.sp,
                  color: lightBlueThemeColor),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          metrophobicText('Price Breakdown', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Amount Paid(Due)', size: 11.sp),
              metrophobicText(sendPageProvider.youSend.toStringAsFixed(2),
                  size: 11.sp)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Amount Exchanged', size: 11.sp),
              metrophobicText(
                  sendPageProvider.amountExchanged.toStringAsFixed(2),
                  size: 11.sp),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          metrophobicText('Net Transfer', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Total INR Transferred',
                  color: lightBlueThemeColor, size: 11.sp),
              metrophobicText(sendPageProvider.youReceiveBank.toString(),
                  size: 11.sp)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Effective mid-market rate',
                  color: lightBlueThemeColor, size: 11.sp),
              metrophobicText(
                  sendPageProvider.effectiveMidMarketRateBank.toString(),
                  size: 11.sp),
            ],
          ),
          metrophobicText('(inc.taxes and charges)', size: 11.sp),
          SizedBox(
            height: 2.h,
          ),
          metrophobicText(
              sendPageProvider.maxValueValidationMessage
                  ? "Maximum allowed transfer is ${maxLimit.toStringAsFixed(0)} USD"
                  : '',
              color: Colors.red,
              size: 11.sp),
        ],
      ),
    );
  }

  Widget creditCard() {
    final sendPageProvider =
        Provider.of<SendPageProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 5.h,
          ),
          metrophobicText('Charges Breakdown', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 0.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Card Processing Charges(4%)', size: 11.sp),
              metrophobicText(
                  sendPageProvider.cardTransferCharge.toStringAsFixed(2),
                  size: 11.sp),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Payezy Platform Fees', size: 11.sp),
              metrophobicText('\$0.00', size: 11.sp),
              //please substract once platform fees is added
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          metrophobicText('Price Breakdown', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Amount Paid(Due)', size: 11.sp),
              metrophobicText(sendPageProvider.youSend.toStringAsFixed(2),
                  size: 11.sp)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Amount Exchanged', size: 11.sp),
              metrophobicText(
                  sendPageProvider.cardAmountExchanged.toStringAsFixed(2),
                  size: 11.sp),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          metrophobicText('Net Transfer', color: lightGrey, size: 10.sp),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Total INR Transferred',
                  color: lightBlueThemeColor, size: 11.sp),
              metrophobicText(sendPageProvider.youReceiveCard.toString(),
                  size: 11.sp)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metrophobicText('Effective mid-market rate',
                  color: lightBlueThemeColor, size: 11.sp),
              metrophobicText(
                  sendPageProvider.effectiveMidMarketRateCard.toString(),
                  size: 11.sp),
            ],
          ),
          metrophobicText('(inc.taxes and charges)', size: 11.sp),
          SizedBox(
            height: 2.h,
          ),
          metrophobicText(
              sendPageProvider.maxValueValidationMessage
                  ? "Maximum allowed transfer is ${maxLimit.toStringAsFixed(0)} USD"
                  : '',
              color: Colors.red,
              size: 11.sp),
        ],
      ),
    );
  }
}
