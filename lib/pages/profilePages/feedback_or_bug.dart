import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/ticket_collection_feedback_or_bug.dart';
import 'package:payezy/providers/profile_page_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FeedbackOrBug extends StatefulWidget {
  const FeedbackOrBug({super.key});

  @override
  State<FeedbackOrBug> createState() => _FeedbackOrBugState();
}

class _FeedbackOrBugState extends State<FeedbackOrBug> {
  late final TextEditingController _issueController;


@override
  void initState() {
     _issueController=TextEditingController();
    super.initState();
  }
@override
  void dispose() {
_issueController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
        final profilePageProvider=Provider.of<ProfilePageProvider>(context,listen: true);

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomContainer(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Padding(
                    padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                   child: customTextField('Explain briefly the issue that you are facing.',
                   controller: _issueController),
                 ),
            
                 SizedBox(height: 2.h,),
                Row(
                  children: [
                   
                     Expanded(
                       child: CustomButton(onPressed: (){
                    Navigator.pushNamed(context, '/createticket',);
                       
                               }
                               , text: 'Back',color: cancelButton,size: 15.sp,),
                     ),
                     SizedBox(width: 5.w),
                 Expanded(
                   child: CustomButton(onPressed: (){
                             addBugorFeedbackReport(_issueController.text, "", "Submitted", "Feedback/Bug");
                                      Navigator.popAndPushNamed(context, '/mainscreen');
            
                           }
                           , text: 'Create',
                           size: 15.sp,
                           rightAssetValue: 'assets/nextIcon.png'),
                 ),
                  ],
                ),
                SizedBox(height: 3.h,),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
