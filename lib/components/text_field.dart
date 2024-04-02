import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

Widget customTextField(String text, String sideText1,
    {String? errorTextVal,
    String? infoText='',
    String? details = '',
    bool? detailsVisible = false,
    String? label = '',
    TextEditingController? controller,
    String? Function(String?)? validator,
    onChanged,
    bool? readOnly = false,
    bool? sidetextVisibility = false,
    bool? infoTextVisibility = false,
    TextInputType? textInputType,
    bool? obscure = false,
    Color sideTextcolor = greyFontThemeColor,
    Color color = greyFontThemeColor,
    List<TextInputFormatter>? inputFormatters,
    dynamic onFieldSubmitted,
    bool enableSuggestions = true}) {
  return
      //main textfield body
      Container(
    //   width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.transparent,
        border: Border.all(color: lightBlueThemeColor)),
    child: Padding(
      padding: EdgeInsets.only(
        left: 3.w,
      ),
//column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
//child1: you send placeholder
          Padding(
            padding:  EdgeInsets.only(top: 1.5.h,),
            child: metrophobicText(text,
                color: greyFontThemeColor, size: 11.sp,height: 0.01.h),
          ),
          Visibility(
            visible: infoTextVisibility!,
            child: Padding(
              padding:  EdgeInsets.only(top: 1.5.h,),
              child: metrophobicText(infoText!,
                  color: yellow, size: 11.sp,height: 0.01.h),
            ),
          ), 
//TextField
//child3:row to arrange textfield and side text
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
//row child1:sized box              
              Expanded(
                //height: 3.5.h,
                //width: sideText1 == '' ? 82.w : 64.w,
                child: TextFormField(
                  validator: validator,
                  textAlignVertical: TextAlignVertical.bottom,
                  enableSuggestions: enableSuggestions,
                  inputFormatters: inputFormatters,
                  controller: controller,
                  obscureText: obscure!,
                  onChanged: onChanged,
                  onFieldSubmitted: onFieldSubmitted,
                  keyboardType: textInputType,
                  cursorHeight: 3.h,
                  cursorColor: white,
                  style: TextStyle(color: white, fontSize: 18.sp,height: 1),
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    isDense: true,
                    constraints: BoxConstraints.tight(Size.fromHeight(5.h)),
                    border: InputBorder.none,
                   //  border: const OutlineInputBorder(borderSide: BorderSide(),  borderRadius: BorderRadius.zero, gapPadding: 0,),
                    hintText: label!,
                    hintStyle: TextStyle(color: color, fontSize: 18.sp),
                    errorText: errorTextVal,
                  ),
                ),
              ),
              Visibility(
                visible: sidetextVisibility!,
                child: Padding(
                  padding:  EdgeInsets.all(1.h),
                  child: SizedBox(
                      child: robotoText(sideText1,
                          size: 18.sp, color: sideTextcolor)),
                ),
              )
            ],
          ),
          Visibility(
              visible: detailsVisible!,
              child: metrophobicText(details!.isNotEmpty ? details : '')),
        ],
      ),
    ),
  );
}
