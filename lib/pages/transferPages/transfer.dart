import 'dart:ui';

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
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: 'Transfer', isVisible: false),
      bottomNavigationBar: BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.h),
        child: const TransferHistory(),
      ),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  final List<Item> _data = generateItems(3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          metrophobicText(
            'Transfer History',
          ),
          SizedBox(
            height: 3.h,
          ),
          _buildPanel(),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: grey,
          hasIcon: false,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
                leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/indiaIcon.png'),
                Image.asset('assets/rupeeIcon.png'),
                metrophobicText('83,223.00', size: 12.sp),
                SizedBox(
                  width: 3.h,
                ),
                metrophobicText('John Doe', size: 12.sp),
                SizedBox(
                  width: 3.h,
                ),
                metrophobicText('25/06/24', size: 8.sp),
                SizedBox(
                  width: 0.3.h,
                ),
                metrophobicText('12.50 PM', size: 8.sp),
              ],
            ));
          },
          body: ListTile(
            title: Column(
              children: [
                Row(
                  
                  children: [
                    Image.asset('assets/rupeeIcon.png'),
                    metrophobicText('1000.00'),
                    SizedBox(width: 33.w,),
                    Container(
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding:MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 1.h)),
                            ),
                            child: metrophobicText('Processing')))
                  ],
                ),
                //end of row one----------------------------------
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        metrophobicText('Transfer ID',
                            color: lightGrey, size: 10.sp),
                        metrophobicText('37823727272', size: 12.sp),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        metrophobicText('Account No.',
                            color: lightGrey, size: 10.sp),
                        metrophobicText('2378473678478930', size: 12.sp),
                      ],
                    ),
                  ],
                ),
                //------------------------row 2 ends--------------------
    SizedBox(height: 3.h,),
    
    //-------------------------row 3 begins-------------------------------//
    Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        metrophobicText('IFSC Code',
                            color: lightGrey, size: 10.sp),
                        metrophobicText('UTIB0003435', size: 12.sp),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        metrophobicText('Phone',
                            color: lightGrey, size: 10.sp),
                        metrophobicText('9889343435', size: 12.sp),
                      ],
                    ),
                  ],
                                
    
                ),
                //--------------------end of row 3
                SizedBox(height:3.h),
              metrophobicText('Please be patient,Your transfer order will be succesfully delievered within 2 hours.',
              size: 11.sp,
              color: orange),
              SizedBox(height: 3.h,),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(onPressed: (){}, text: "Cancel & Refund",size: 16.sp,)),
              ],
              
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
