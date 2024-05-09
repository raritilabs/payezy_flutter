import 'package:flutter/material.dart';
//custom app bar
import 'package:payezy/components/custom_container.dart'; // custom main body card
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:payezy/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart'; //colors

class HelpAndSupportHomePage extends StatefulWidget {
  const HelpAndSupportHomePage({super.key});

  @override
  State<HelpAndSupportHomePage> createState() => _HelpAndSupportHomePageState();
}

class _HelpAndSupportHomePageState extends State<HelpAndSupportHomePage> {
  @override
  Widget build(BuildContext context) {
    final Uri exploreDocsUri = Uri.parse('https://docs.payezy.io/');
    return Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: white),
          leading: IconButton(onPressed: (){
            Navigator.pushNamed(context, '/mainscreen');
          }, 
          icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
              top: 3.h,
            ),
            child: CustomContainer(
              //custom container
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 1.h),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        //title
                        child: metrophobicText('Help & Support', size: 20.sp)),
                  ),
                  //horizontal line
                  customLine(100.w),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        children: [
                          //Create ticket button
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/createticket');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: lightBlueThemeColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 5.w),
                                child: metrophobicText(
                                    'Create a support ticket',
                                    size: 20.sp,
                                    textAlign: TextAlign.left,
                                    color: lightBlueThemeColor),
                              ),
                            ),
                          ),
                          //space b/w
                          SizedBox(
                            height: 2.h,
                          ),
                          //Explore Docs
                          GestureDetector(
                            onTap: () {
                              launchUrl(exploreDocsUri,
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: lightBlueThemeColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 5.w),
                                child: metrophobicText('Explore Docs',
                                    size: 20.sp,
                                    textAlign: TextAlign.left,
                                    color: lightBlueThemeColor),
                              ),
                            ),
                          ),
                          //space b/w
                          SizedBox(
                            height: 2.h,
                          ),
                          //for any queries
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: metrophobicText(query, size: 15.sp),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                launchUrl(Uri(
                                    scheme: 'mailto',
                                    path: "support@rariti.io",
                                    queryParameters: {
                                      'subject': "support",
                                    }));
                              },
                              child: metrophobicText('support@rariti.io',
                                  color: yellow, size: 15.sp),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
}
