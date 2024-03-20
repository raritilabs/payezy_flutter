import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/api_provider.dart';
import 'package:payezy/providers/enter_details_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/functions/add_data.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({super.key});

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  //initialising texteditingcontrollers
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _bAccountNumber = TextEditingController();
  final TextEditingController _iFSC = TextEditingController();
  final TextEditingController _confirmAccount = TextEditingController();


@override
  void dispose() {
        _fName.dispose();
    _phone.dispose();
    _bAccountNumber.dispose();
    _iFSC.dispose();
    _confirmAccount.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    final enterDetailsProvider = Provider.of<EnterDetailsProvider>(
      context,listen: true
    );
    final ifscApiProvider=Provider.of<ApiProvider>(context,listen: true);

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
              textInputType: TextInputType.name,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z\\s]'))],
              onChanged: (value) => enterDetailsProvider.setfName(value)),
          details(phone, 
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputType:TextInputType.phone,
          controller: _phone, onChanged: (value) {
            
                enterDetailsProvider.setPhone(int.tryParse(value)??0);
             
          }),
          details(bankaccnum,
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
           controller: _bAccountNumber, onChanged: (value) {
                           enterDetailsProvider.setBankAccNum(int.tryParse(value)??0);

          }),
          details(confirmacc, 
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: _confirmAccount, onChanged: (value) {
                            enterDetailsProvider.setconfirmAcc(int.tryParse(value)??0);

          }),
          details(ifsc,
              controller: _iFSC,
              onChanged: (value) async{
                ifscApiProvider.setiFSC((value));
                await ifscApiProvider.getDataFromAPI();
                
              }
              
              ),
          SizedBox(
            child: switch (enterDetailsProvider.validationMessage) {
              ValidationMessage.fnameVM => metrophobicText(
                 
                      "Please enter a full name",
                     
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.bAccountNumberVM => metrophobicText(
                       "Please enter a valid account number",
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.confirmAccountVM => metrophobicText(
                 
                       "Please confirm the account number"
                      ,
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.iFSCVM => metrophobicText(
                       "Please enter an IFSC Code"
                    
                     //ifscApiProvider.isLoading?'loading':ifscApiProvider.values.ifsc
                    ,
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.phoneVM => metrophobicText(
                       "Please enter a 10-digit phone number"
                    ,
                  color: Colors.red,
                  size: 11.sp),
              ValidationMessage.initial => metrophobicText(''),
            },
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: 2.h, top: 1.h, left: 5.w, right: 5.w),
            child: CustomButton(
              onPressed: ()  {
               //  enterDetailsProvider.setValidationMessage(ValidationMessage.iFSCVM);
                if (enterDetailsProvider.fname.isEmpty) {
                  enterDetailsProvider.setValidationMessage(ValidationMessage.fnameVM);
                }
                 else if (enterDetailsProvider.phone.toString().length != 10) {
            enterDetailsProvider.setValidationMessage(ValidationMessage.phoneVM);
      
                } else if(enterDetailsProvider.bAccountNumber.toString().length !=16) {
                  enterDetailsProvider.setValidationMessage(ValidationMessage.bAccountNumberVM);
                }
                
                else if (enterDetailsProvider.confirmAccount !=
                    enterDetailsProvider.bAccountNumber) {
      
                                 enterDetailsProvider.setValidationMessage(ValidationMessage.confirmAccountVM);
      
                } 
                
                else 
                {
                 
                  enterDetailsProvider.setValidationMessage(ValidationMessage.initial);
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
    {TextEditingController? controller,TextInputType? textInputType, dynamic onChanged, List<TextInputFormatter>? inputFormatters
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
    child: customTextField(title, '',
        controller: controller, onChanged: onChanged,
        inputFormatters:inputFormatters,
        textInputType: textInputType,
        ),
  );
}

