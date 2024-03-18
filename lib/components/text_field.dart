import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

Widget customTextField(String text, String sideText1,
    {String? errorTextVal,
    String? label = '',
    TextEditingController? controller,
    String? Function(String?)? validator,
    onChanged,
    bool? readOnly = false,
    TextInputType? textInputType,
    bool? obscure = false,
    Color sideTextcolor = greyFontThemeColor,
    Color color = greyFontThemeColor}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
        border: Border.all(color: lightBlueThemeColor)),
    child: Padding(
      padding: EdgeInsets.only(
        left: 3.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          metrophobicText(text, color: greyFontThemeColor, size: 11.sp),

          //TextField

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 3.5.h,
                width: sideText1 == '' ? 74.w : 64.w,
                child: TextFormField(
                  validator: validator,
                  textAlignVertical: TextAlignVertical.bottom,
                  //autofocus: true,
                  //  autovalidateMode: AutovalidateMode.onUserInteraction,

                  controller: controller,
                  obscureText: obscure!,
                  onChanged: onChanged,
                  keyboardType: textInputType,
                  style: TextStyle(color: white, fontSize: 18.sp),
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,

                    border: InputBorder.none,
                    // border: OutlineInputBorder(borderSide: BorderSide(),borderRadius: BorderRadius.zero,),
                    hintText: label!,
                    hintStyle: TextStyle(color: color, fontSize: 18.sp),
                    errorText: errorTextVal,
                  ),
                ),
              ),
              SizedBox(
                  child:
                      robotoText(sideText1, size: 18.sp, color: sideTextcolor))
            ],
          ),
        ],
      ),
    ),
  );
}
