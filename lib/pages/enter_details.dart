import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';

class EnterDetails extends StatelessWidget {
  const EnterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Enter the details...
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: titleText(enterthedetails),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        details(fullname),
        details(phone),
        details(bankaccnum),
        details(confirmacc),
        details(ifsc),

        Padding(
          padding:
              const EdgeInsets.only(bottom: 10, top: 15, left: 15, right: 15),
          child: CustomButton(onPressed:() {
            showDialog(
                barrierColor: blurColor,
                context: context,
                builder: (BuildContext context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: AlertDialog(
                        backgroundColor: mainBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: alertText(
                          areyousure,
                          white,
                          25,
                        ),
                        content: alertText(note, lightBlueThemeColor, 12),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(onPressed: () {
                                  Navigator.pushNamed(context, './cybrid');
                                }, text:confirm,size: 15,color:
                                    lightBlueThemeColor),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CustomButton(onPressed: () {
                                  Navigator.pop(context);
                                }, text:cancel, size:15, color:cancelButton,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
          }, text:proceed, size:22, color:white,rightAssetValue: "assets/nextIcon.png",),
        ),
      ],
    );
  }
}

Widget details(title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: customTextField(title, ''),
  );
}
