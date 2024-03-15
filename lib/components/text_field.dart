import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

Widget customTextField(String text,String sideText1,{String? label='',TextEditingController? controller,onChanged,bool? readOnly=false,TextInputType? textInputType, bool? obscure=false, Color sideTextcolor=greyFontThemeColor,Color color=greyFontThemeColor}){

return Container(
                        width: double.infinity,
                     
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                            border: Border.all(
                                color:lightBlueThemeColor)),
                        child:  Padding(
                          padding:EdgeInsets.only(left: 5.w, top: 0.5.h,),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,                      
                                children: [
                                  //You Send
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: metrophobicText(text,
                                      color: greyFontThemeColor,
                                      size: 11.sp)
                                      ),
                                SizedBox(height: 0.8999.h,),
                                 
                                  //TextField
                              
                                   SizedBox(
                                    height: 3.5.h,
                                    width: 28.h,
                                    child: TextField(
                                      scrollPadding: EdgeInsets.only(
            bottom: 10),
                                      controller: controller,
                                     obscureText: obscure!,
                                      onChanged:onChanged,
                                      keyboardType:textInputType,
                                      style:  TextStyle(color: white,fontSize: 18.sp),
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                         hintText:label!,
                                        hintStyle: TextStyle( color: color, fontSize: 18.sp),
                                         ),
                                    ),
                                     ),
                                   
                                ],
                              ),
                               SizedBox(
                                  height: 3.5.h,
                                  child: robotoText(sideText1,size: 18.sp,color: sideTextcolor))
                            ],
                          ),
                        ),
                      );
}