
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:sizer/sizer.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
 // late Animation<Offset> _animation;
  late Animation<double> _animation;
 @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
    );

   _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
   /*Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Off-screen top
      end: Offset.zero,
    ).
    animate(CurvedAnimation(parent: _controller, curve: Curves.ease));*/
  }


  int selectedItemIndex = -1;
  

  void toggleVisibility(int index) {
    setState(() {
      if (selectedItemIndex == index) {
        // If the same item is clicked again, hide the container
        selectedItemIndex = -1;
         _controller.reverse();
      } else {
        // If a different item is clicked, show its container
        selectedItemIndex = index;
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //calling fetchDataProvider
    //final fetchDataProvider = Provider.of<FetchDataProvider>(context,listen: true);
    return Scaffold(
            resizeToAvoidBottomInset: false,

        backgroundColor: mainBackgroundColor,
        appBar: const CustomAppBar(
          title: "Transfers",
        ),
       // bottomNavigationBar: const BottomNavBar(),
        body: Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 5.w,
            right: 5.w,
          ),
          child: StreamBuilder(

              ///fetches data continously
              stream:
                  FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (
                context,
                snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //----------------------------transfer history---------------------------------------//
                       metrophobicText('Transfer History', size: 17.sp),
                       SizedBox(
                          height: 2.h,
                        ),
                        //----------------------------history header----------------------------------------//
                        //padding 1.h and 3.w
                        //main axis.space between
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 2.h);
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  toggleVisibility(index);
                                },
                                child: CustomContainer(
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 3.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: .5.h),
                                                child: Image.asset(
                                                    'assets/indiaIcon.png'),
                                              ),
                                              Image.asset(
                                                  'assets/rupeeIcon.png'),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.5.h),
                                                child: metrophobicText(
                                                    '83,223.00',
                                                    size: 13.sp),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: .5.w,
                                                ),
                                                child: Image.asset(
                                                  'assets/tranferIcon.png',
                                                ),
                                              ),
                                              metrophobicText(
                                                  (((snapshot.data!.docs[index]["First Name"]).toString().length)>6)?
                                                  (snapshot.data!.docs[index]["First Name"]).toString().substring(0,6):
                                                  (snapshot.data!.docs[index]["First Name"]).toString(),
                                                  
                                                  size: 13.sp),
                                            ],
                                          ),
                                          metrophobicText('25/06/24 12.50 PM',
                                              size: 9.sp, color: lightGrey),
                                        ],
                                      ),
                                    ),
                                  
                                  //-----------------End of top card------------------------------------------------------//
                                  //------------------------expands here------------------------------------------------//
                                    Visibility(
                                      visible: selectedItemIndex == index
                                          ? true
                                          : false,
                                      child: FadeTransition(
                                        opacity:_animation,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: .5.h),
                                                        child: Image.asset(
                                                            'assets/USIcon.png'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                    0.5.h),
                                                        child: metrophobicText(
                                                            '\$ 1000.00',
                                                            size: 13.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: yellow,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 3.w,
                                                                vertical: 0.3.h),
                                                        child: metrophobicText(
                                                            'Processing'),
                                                      )),
                                                ],
                                              ),
                                                                              
                                              //end of row one----------------------------------
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        'Transfer ID',
                                                        color: lightGrey,
                                                        size: 10.sp),
                                                  )),
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        'Account No.',
                                                        color: lightGrey,
                                                        size: 10.sp),
                                                  )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        '37823727272',
                                                        size: 12.sp),
                                                  )),
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        "${snapshot.data!.docs[index]['Bank Acc Number']}",
                                                        size: 12.sp),
                                                  )),
                                                ],
                                              ),
                                                                              
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                                                              
                                              //------------------------row 2 ends--------------------
                                                                              
                                              //-------------------------row 3 begins-------------------------------//
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        'IFSC Code',
                                                        color: lightGrey,
                                                        size: 10.sp),
                                                  )),
                                                                              
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        'Phone',
                                                        color: lightGrey,
                                                        size: 10.sp),
                                                  )),
                                                                              
                                                  
                                                ],
                                              ),
                                                                              
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        "${snapshot.data!.docs[index]['IFSC Code']}",
                                                        size: 12.sp),
                                                  )),
                                                                              
                                                  Expanded(
                                                      child: SizedBox(
                                                    child: metrophobicText(
                                                        "${snapshot.data!.docs[index]['Phone']}",
                                                        size: 12.sp),
                                                  )),
                                                                              
                                                  // Expanded(child: SizedBox()),
                                                ],
                                              ),
                                                                              
                                              SizedBox(height: 3.h),
                                              metrophobicText(
                                                  'Please be patient,Your transfer order will be succesfully delievered within 2 hours.',
                                                  size: 10.sp,
                                                  color: yellow),
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
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    )
                                  ]),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const SizedBox();
              }),
        ));
  }
}
