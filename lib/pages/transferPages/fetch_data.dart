import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/components/custom_line.dart';
import 'package:payezy/functions/format_epoch_time.dart';
import 'package:payezy/functions/get_user_transaction_history.dart';
import 'package:payezy/pages/profilePages/failed_transaction.dart';
import 'package:payezy/providers/fetch_data_provider.dart';
import 'package:payezy/providers/profile_page_provider.dart';
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
    final fetchDataProvider=Provider.of<FetchDataProvider>(context,listen: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mainBackgroundColor, 
        appBar: const CustomAppBar(
          title: "Transfers",
        ),
        body: Padding(
            padding: EdgeInsets.only(
              top: 2.h,
              left: 5.w,
              right: 5.w,
            ),
            child: switch(fetchDataProvider.transferPage){
               
              TransferPages.transferhistory => const TransferHistory(),
              TransferPages.transferissue => const FailedTransaction(),
            }));

}
    }


class TransferHistory extends StatefulWidget {
  const TransferHistory({super.key});

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> 

   with SingleTickerProviderStateMixin {
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

  String email = FirebaseAuth.instance.currentUser!.email.toString();

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
        final fetchDataProvider=Provider.of<FetchDataProvider>(context,listen: true);
        final profilePageProvider=Provider.of<ProfilePageProvider>(context,listen: true);

    return  FutureBuilder(

                ///fetches data continously
                future: _fetchAccountDetails(),
                builder: (
                  context,
                  snapshot1,
                ) {
                  return FutureBuilder(
                      future: getUserTransactionHistory(),
                      builder: (context, snapshot2) {
                        if (!snapshot2.hasData) return const Text('Loading...');
                        if (!snapshot1.hasData) return const Text('Loading...');

                        return CustomContainer(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //----------------------------transfer history---------------------------------------//
                                //title card
                               Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
                                    child: metrophobicText('Transfer History', size: 17.sp),
                                  ),
                                
                                //gap b/w
                                SizedBox(height: 1.h,),
                                //line
                                customLine(100.w),
                                //gap b/w                         
                                SizedBox(
                                  height: 2.h,
                                ),
                                //----------------------------history header----------------------------------------//
                                //padding 1.h and 3.w
                                //main axis.space between
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (context,index) {
                                      return SizedBox(height: 2.h);
                                    },
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          toggleVisibility(index);//visible on click
                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 2.h),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: transferBodyColor),
                                            child: Column(
                                              children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3.h, horizontal: 3.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //first row set to show inr value
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: .5.h),
                                                          child: Image.asset(
                                                              'assets/indiaIcon.png'),
                                                        ),
                                                        Image.asset(
                                                            'assets/rupeeIcon.png'),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      0.5.h),
                                                          child: metrophobicText(
                                                              snapshot2.data[
                                                                      'extractedDetails']
                                                                      [index]
                                                                      ['inr_amount']
                                                                  .toString(),
                                                              size: 13.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    //second row set for usd value
                                                   Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              .5.h),
                                                                  child: Image.asset(
                                                                      'assets/USIcon.png'),
                                                                ),
                                                                metrophobicText(
                                                            '\$'),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              0.5.h),
                                                                  child: metrophobicText(
                                                                      snapshot2
                                                                          .data[
                                                                              'extractedDetails']
                                                                              [index][
                                                                              'usd_amount_net']
                                                                          .toString(),
                                                                      size: 13.sp),
                                                                ),
                                                              ],
                                                            ), 
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
                                                  opacity: _animation,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 3.w),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        //transfer ID title
                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: SizedBox(
                                                                                                                                 child:
                                                                    metrophobicText(
                                                                        'Transfer ID',
                                                                        color:
                                                                            greyFontThemeColor,
                                                                        size: 12.sp),
                                                                ),
                                                            ),
                                                            //transfer id
                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: SizedBox(
                                                                   
                                                                child: robotoText(
                                                                    snapshot2.data[
                                                                            'extractedDetails']
                                                                            [index][
                                                                            'order_id']
                                                                            ['S']
                                                                        .toString(),
                                                                    size: 11.sp),
                                                                                                                          ),
                                                            ),
                                                            SizedBox(height: 2.h,),
                                                              //payment status
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: yellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            3.w,
                                                                        vertical:
                                                                            0.3.h),
                                                                child: metrophobicText(
                                                                    (snapshot2.data[
                                                                            'extractedDetails'][index]
                                                                        [
                                                                        'tx_status'])=='payment_received'?'Awaiting settlement':'error',color: white),
                                                              ),
                                                            ),

                                                      SizedBox(
                                                          height: 2.h,
                                                        ),
//Account No title
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          
                                                        SizedBox(
                                                                 child:
                                                                 metrophobicText(
                                                                     'Account No.',
                                                                     color:
                                                                         greyFontThemeColor,
                                                                     size: 12.sp),                                                         
                                                        ),
                                                        //transaction fee title
                                                          SizedBox(
                                                                 child:
                                                                 metrophobicText(
                                                                     'Transaction Fee',
                                                                     color:
                                                                         greyFontThemeColor,
                                                                     size: 12.sp),                                                         
                                                        ),
                                                        ]
                                                        ), 
                                                        //account number value   
                                                         Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                          SizedBox(
                                                         child: robotoText(
                                                              snapshot1.data!.docs.first['accountNumber'],                  
                                                            size: 11.sp),),
                                                            //transaction fee
                                                         SizedBox(
                                                         child: robotoText('\$${snapshot2
                                                                          .data[
                                                                              'extractedDetails']
                                                                              [index][
                                                                              'tx_cost'].toString()}.00',
                                                                      
                                                                          
                                                                      size: 11.sp),),
                                                          ],),
                                                            SizedBox(height: 1.h,),
                                                            //Total cost
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          
                                                        SizedBox(
                                                                 child:
                                                                 metrophobicText(
                                                                     'Total Cost',
                                                                     color:
                                                                         greyFontThemeColor,
                                                                     size: 12.sp),                                                         
                                                        ),
                                                          SizedBox(
                                                                 child:
                                                                 metrophobicText(
                                                                     'Payment Ref',
                                                                     color:
                                                                         greyFontThemeColor,
                                                                     size: 12.sp),                                                         
                                                        ),
                                                        ]
                                                        ), 
                                                           //total cost and payment ref values
                                                         Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                          SizedBox(
                                                         child: robotoText(
                                                              '\$ ${snapshot2
                                                                          .data[
                                                                              'extractedDetails']
                                                                              [index][
                                                                              'usd_amount']}',                 
                                                            size: 11.sp),),
                                                         SizedBox(
                                                         child: robotoText('-',size: 11.sp),),
                                                          ],),
                                                            SizedBox(height: 1.h,),
                                                       //exchange rate

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [ 
                                                      SizedBox(
                                                                   child:
                                                                   metrophobicText(
                                                                   'Exchange Rate',
                                                                    color:
                                                                    greyFontThemeColor,
                                                                         size: 12.sp),                                                         
                                                            ),
                                                      
                                                             SizedBox(
                                                             child: robotoText('${
                                                                  snapshot2
                                                                              .data[
                                                                                  'extractedDetails']
                                                                                  [index][
                                                                                  'exchange_rate']} INR',                  
                                                                size: 11.sp),),                                                        
                                                            
                                                            ]
                                                            ),
                                                            
                                                    GestureDetector(
                                                      onTap: (){
                                               profilePageProvider.setOrderId(snapshot2.data[
                                                                            'extractedDetails']
                                                                            [index][
                                                                            'order_id']
                                                                            ['S']
                                                                        .toString(),);
                                               fetchDataProvider.setTransferPage(TransferPages.transferissue);
                                                      },
                                                      child: Container(
                                                            decoration: BoxDecoration(
                                                              color: darkGrey,
                                                              borderRadius: BorderRadius.circular(4),
                                                              border: Border.all(
                                                                color: borderLightGrey,
                                                              )
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 3.h,vertical: 1.2.w),
                                                              child: metrophobicText('Support',
                                                              color: yellow,size: 12.sp),
                                                            ),),
                                                    ),
                                                    ],
                                                  ), 
                                                           //total cost and payment ref values
                                                SizedBox(height: 1.h,),                                                               
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                                                                                          child:
                                                              metrophobicText(
                                                                  'Phone',
                                                                  color:
                                                                      greyFontThemeColor,
                                                                  size: 12.sp),
                                                                                                                        ),
                                                            SizedBox(
                                                                                                                          child:
                                                              metrophobicText(
                                                                  'IFSC Code',
                                                                  color:
                                                                      greyFontThemeColor,
                                                                  size: 12.sp),
                                                                                                                        ),
                                                          ],
                                                        ),
                                                                    
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                             SizedBox(child: robotoText(
                                                              snapshot1
                                                                      .data!
                                                                      .docs
                                                                      .first[
                                                                  'phoneNumber'],
                                                              size: 11.sp),),                                                                       
                                                            SizedBox( child: robotoText(
                                                              snapshot1
                                                                      .data!
                                                                      .docs
                                                                      .first[
                                                                  'IFSCCode'],
                                                              size: 11.sp),),                                                                                      
                                                          ],
                                                        ),  
                                     SizedBox(height: 2.h,),                               
                                                        
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                                                                                          child:
                                                              metrophobicText(
                                                                  'Full Name',
                                                                  color:
                                                                      greyFontThemeColor,
                                                                  size: 12.sp),
                                                                                                                        ),
                                                            SizedBox(
                                                                                                                          child:
                                                              metrophobicText(
                                                                  'Time',
                                                                  color:
                                                                      greyFontThemeColor,
                                                                  size: 12.sp),
                                                                                                                        ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                             SizedBox(child: robotoText(
                                                              snapshot1
                                                                      .data!
                                                                      .docs
                                                                      .first[
                                                                  'fullName'],
                                                              size: 11.sp),),                                                                       
                                                            SizedBox( child: robotoText(
                                                             DateUtilsFunction
                                                             .formatEpochTime(
                                                           int.parse(
                                                             snapshot2.data[
                                                                     'extractedDetails']
                                                                     [index]
                                                                     ['created_at']
                                                                 .toString())),
                                                              size: 11.sp),),                                                                                      
                                                    
                                                      ]),                                                                   
                                                        SizedBox(height: 3.h),
                                                        metrophobicText(
                                                            'Your payment has been received. Your transfer order will be delivered in 48 hours. Thank you for your patience.',
                                                            size: 10.sp,
                                                            color: yellow,
                                                            textAlign: TextAlign.justify),
                                                                                                                                                                    
                                            ]),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              )
                                            ]),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: snapshot2.data!['extractedDetails'].length,
                                  ),
                                ),
                              ]),
                        );
                      });
                });
  }
}



Future<QuerySnapshot> _fetchAccountDetails() async {
  String? email = FirebaseAuth.instance.currentUser!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .where('email', isEqualTo: email)
      .get();
  final userId = querySnapshot.docs.first.id;
  final accountDetailsSnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .doc(userId)
      .collection('accountDetails')
      .get();
  return accountDetailsSnapshot;
}
