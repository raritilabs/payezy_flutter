import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/bottom_nav_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    //calling fetchDataProvider
    final fetchDataProvider = Provider.of<FetchDataProvider>(context);
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(
        title: "Transfer",
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          fetchDataProvider.isVisible();
                        },
                        child: CustomContainer(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/indiaIcon.png'),
                                    Image.asset('assets/rupeeIcon.png'),
                                    metrophobicText('83,223.00', size: 13.sp),
                                  ],
                                ),
                                metrophobicText(
                                    "${snapshot.data!.docs[index]["First Name"]}",
                                    size: 13.sp),
                                metrophobicText('25/06/24 12.50 PM',
                                    size: 9.sp),
                              ],
                            ),
                            Visibility(
                              visible: fetchDataProvider.visibility,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 0.3.h),
                                              child:
                                                  metrophobicText('Processing'),
                                            )),
                                      ],
                                    ),
                  
                                    //end of row one----------------------------------
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            metrophobicText('Transfer ID',
                                                color: lightGrey, size: 10.sp),
                                            metrophobicText('37823727272',
                                                size: 12.sp),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            metrophobicText('Account No.',
                                                color: lightGrey, size: 10.sp),
                                            metrophobicText(
                                                "${snapshot.data!.docs[index]['Bank Acc Number']}",
                                                size: 12.sp),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                      ],
                                    ),
                                    //------------------------row 2 ends--------------------
                                    SizedBox(
                                      height: 3.h,
                                    ),
                  
                                    //-------------------------row 3 begins-------------------------------//
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            metrophobicText('IFSC Code',
                                                color: lightGrey, size: 10.sp),
                                            metrophobicText(
                                                "${snapshot.data!.docs[index]['IFSC Code']}",
                                                size: 12.sp),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            metrophobicText('Phone',
                                                color: lightGrey, size: 10.sp),
                                            metrophobicText(
                                                "${snapshot.data!.docs[index]['Phone']}",
                                                size: 12.sp),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                  
                                    SizedBox(height: 3.h),
                                    metrophobicText(
                                        'Please be patient,Your transfer order will be succesfully delievered within 2 hours.',
                                        size: 10.sp,
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
                      );
                      // ListTile(
                      //   title: metrophobicText(
                      //       "${snapshot.data!.docs[index]["First Name"]}"),
                      // );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                }
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
