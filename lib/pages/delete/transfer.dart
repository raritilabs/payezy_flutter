import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

/// Flutter code sample for [ExpansionPanelList].

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: false,

      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: 'Transfer', isVisible: false),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.h),
        child: const TransferHistory(),
      ),
    );
  }
}

class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        metrophobicText('Transfer History', size: 17.sp),
        SizedBox(
          height: 3.h,
        ),
        CustomContainer(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _visibility = !_visibility;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/indiaIcon.png'),
                        Image.asset('assets/rupeeIcon.png'),
                        metrophobicText('83,223.00', size: 13.sp),
                      ],
                    ),
                    metrophobicText('John Doe', size: 13.sp),
                    metrophobicText('25/06/24 12.50 PM', size: 9.sp),
                  ],
                ),
              ),
              Visibility(
                visible: _visibility,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/USIcon.png'),
                              Image.asset('assets/rupeeIcon.png'),
                              metrophobicText('1000.00'),
                            ],
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.3.h),
                                child: metrophobicText('Processing'),
                              )),
                        ],
                      ),

                      //end of row one----------------------------------
                      SizedBox(height: 3.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              metrophobicText('Transfer ID',
                                  color: lightGrey, size: 10.sp),
                              metrophobicText('37823727272', size: 12.sp),
                            ],
                          ),
                         
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              metrophobicText('Account No.',
                                  color: lightGrey, size: 10.sp),
                              metrophobicText('2378473678478930', size: 12.sp),
                            ],
                          ),
                          SizedBox(width: 2.w,),
                        ],
                      ),
                      //------------------------row 2 ends--------------------
                      SizedBox(
                        height: 3.h,
                      ),

                      //-------------------------row 3 begins-------------------------------//
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              metrophobicText('IFSC Code',
                                  color: lightGrey, size: 10.sp),
                              metrophobicText('UTIB0003435', size: 12.sp),
                            ],
                          ),
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              metrophobicText('Phone',
                                  color: lightGrey, size: 10.sp),
                              metrophobicText('9889343435', size: 12.sp),
                            ],
                          ),
                          SizedBox(width: 18.w,),
                        ],
                      ),
                      //--------------------end of row 3
                      SizedBox(height: 3.h),
                      metrophobicText(
                          'Please be patient,Your transfer order will be succesfully delievered within 2 hours.',
                          size: 11.sp,
                          color: orange),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: "Cancel & Refund",
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        )
      ],
    )
        );
  }
}