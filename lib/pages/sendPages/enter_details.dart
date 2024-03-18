import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/enter_details_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({super.key});

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _bAccountNumber = TextEditingController();
  final TextEditingController _iFSC = TextEditingController();
  final TextEditingController _confirmAccount = TextEditingController();

  addData(String fname, int phone, int bankaccnum, Object ifsc) async {
    if (fname == "" && phone == 0 && bankaccnum == 0 && ifsc == 0) {
      const Text('Enter Required Fields');
    } else {
      FirebaseFirestore.instance.collection('Users').doc(fname).set({
        "First Name": fname,
        "Phone": phone,
        "Bank Acc Number": bankaccnum,
        "IFSC Code": ifsc,
      }).then((value) => print('inserted'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final enterDetailsProvider = Provider.of<EnterDetailsProvider>(
      context,listen: true
    );

    return SingleChildScrollView(
      reverse: true,
      child: Column(
        
        children: [
          ///Enter the details...
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: metrophobicText(enterthedetails, size: 12.sp),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
      
          details(fullname,
              controller: _fName,
              onChanged: (value) => enterDetailsProvider.setfName(value)),
          details(phone, controller: _phone, onChanged: (value) {
            try {
              if (value != null || value!.isEmpty) {
                enterDetailsProvider.setPhone(int.parse(value));
              }
            } catch (e) {
              print('error is $e');
            }
          }),
          details(bankaccnum, controller: _bAccountNumber, onChanged: (value) {
            try {
              if (value != null || value!.isEmpty) {
                enterDetailsProvider.setBankAccNum(int.parse(value));
              }
            } catch (e) {
              print('error is $e');
            }
          }),
          details(confirmacc, controller: _confirmAccount, onChanged: (value) {
            try {
              if (value != null || value!.isEmpty) {
                enterDetailsProvider.setconfirmAcc(int.parse(value));
              }
            } catch (e) {
              print('error is $e');
            }
          }),
          details(ifsc,
              controller: _iFSC,
              onChanged: (value) => enterDetailsProvider.setiFSC((value))),
          SizedBox(
            child: switch (enterDetailsProvider.validationMessage) {
              ValidationMessage.fnameVM => metrophobicText(
                 // enterDetailsProvider.fnameValidationMessage
                      //? 
                      "Please enter a full name",
                      //: '',
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.bAccountNumberVM => metrophobicText(
                  //enterDetailsProvider.bAccountValidationMessage
                    //  ?
                       "Please enter an account number"
                     ,// : '',
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.confirmAccountVM => metrophobicText(
                  //enterDetailsProvider.confirmAccountValidationMessage
                      //?
                       "Please confirm the account number"
                      ,//: '',
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.iFSCVM => metrophobicText(
                 // enterDetailsProvider.iFSCValidationMessage
                      //?
                       "Please enter an IFSC Code"
                    ,//  : '',
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.phoneVM => metrophobicText(
                  //enterDetailsProvider.phoneValidationMessage
                     // ?
                       "Please enter a 10-digit phone number"
                    ,//  : '',
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.initial => null,
            },
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: 2.h, top: 1.h, left: 5.w, right: 5.w),
            child: CustomButton(
              onPressed: () {
                if (enterDetailsProvider.fname.isEmpty) {
                 // enterDetailsProvider.setfnameValidationMessage();
                  enterDetailsProvider.setValidationMessage(ValidationMessage.fnameVM);
                } else if (enterDetailsProvider.phone.toString().length != 10) {
                 // enterDetailsProvider.setphoneValidationMessage();
            enterDetailsProvider.setValidationMessage(ValidationMessage.phoneVM);
      
                } else if (enterDetailsProvider.confirmAccount !=
                    enterDetailsProvider.bAccountNumber) {
      
                      print(enterDetailsProvider.confirmAccount);
                      print(enterDetailsProvider.bAccountNumber);
                                 enterDetailsProvider.setValidationMessage(ValidationMessage.confirmAccountVM);
      
                 // enterDetailsProvider.setconfirmAccountValidationMessage();
                } 
                else 
                {
                  showDialog(
                      barrierColor: blurColor,
                      context: context,
                      builder: (BuildContext context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: AlertDialog(
                              backgroundColor: mainBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: metrophobicText(
                                areyousure,
                                size: 15.sp,
                              ),
                              content: metrophobicText(note,
                                  color: lightBlueThemeColor, size: 10.sp),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                          onPressed: () {
                                            addData(
                                              enterDetailsProvider.fname,
                                              enterDetailsProvider.phone,
                                              enterDetailsProvider.bAccountNumber,
                                              enterDetailsProvider.iFSC,
                                            );
                                            Navigator.pushNamed(
                                                context, '/cybrid');
                                          },
                                          text: confirm,
                                          size: 15,
                                          color: lightBlueThemeColor),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: cancel,
                                        size: 15,
                                        color: cancelButton,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                }
              },
              text: proceed,
              size: 17.sp,
              color: white,
              rightAssetValue: "assets/nextIcon.png",
            ),
          ),
        ],
      ),
    );
  }
}

Widget details(String title,
    {TextEditingController? controller, dynamic onChanged}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
    child: customTextField(title, '',
        controller: controller, onChanged: onChanged),
  );
}
