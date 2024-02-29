import 'package:flutter/material.dart';
import 'package:payezy/themes/colors.dart';

Widget customTextField(String text,String label){

return Container(
                        width: double.maxFinite,
                        height: 80,
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
                                    style: const TextStyle(
                                        color: greyFontThemeColor,
                                        fontSize: 15),
                                  )),
                            

                              //TextField

                               SizedBox(
                                height: 35,
                                child: TextField(
                                  style: const TextStyle(color: white),
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(color: white),
                                      
                                      label:Text(label),
                                      labelStyle: const TextStyle(
                                          color: white, fontSize: 20)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
}