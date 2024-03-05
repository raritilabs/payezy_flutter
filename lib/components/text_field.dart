import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

Widget customTextField(String text,[String? label='',TextEditingController? controller,onChanged,bool? readOnly=false,TextInputType? textInputType, bool? obscure=false]){

return Container(
                        width: double.infinity,
                     
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                            border: Border.all(
                                color:lightBlueThemeColor)),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //You Send
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    text,
                                    style:  TextStyle(
                                        color: greyFontThemeColor,
                                        fontSize: 16.sp),
                                  )),
                            

                              //TextField

                               SizedBox(
                                height: 4.h,
                                child: TextField(
                                  obscureText: obscure!,
                                  onChanged:onChanged,
                                  keyboardType:textInputType,
                                  style: const TextStyle(color: white),
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(color: white),
                                      border: InputBorder.none,
                                      label:Text(label!,),
                                      labelStyle:  TextStyle(
                                          color: white, fontSize: 20.sp)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
}