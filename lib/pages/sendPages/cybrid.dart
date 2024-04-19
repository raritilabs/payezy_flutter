import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/add_review.dart';
import 'package:payezy/providers/review_and_ratings_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Cybrid extends StatelessWidget {
  const Cybrid({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: white),
title: metrophobicText('Cybrid',size: 20.sp),
      ),
      body: 
      Column(
        children: [
          SizedBox(height: 10.h,),
          CustomButton(onPressed: (){
            Navigator.pushNamed(context, '/reviewpage');
          },
           text: 'Proceed',size: 20.sp,),
        ],
      ),
    );
  }
}

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
late final TextEditingController _feedbackController;

@override
  void initState() {
 _feedbackController=TextEditingController();    
super.initState();
  }
  @override
  void dispose() {
_feedbackController.dispose(); 
super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewAndRatingProvider=Provider.of<ReviewAndRatingsProvider>(context,listen: true);
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: white),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 15.h,),
              metrophobicText(
        "Transaction complete! Happy with our service? Leave a review!",size: 12.sp),
        SizedBox(height: 5.h,),
        Center(
          child: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
            itemBuilder: (context,_)=>Icon(Icons.star_outlined,color: yellow,), onRatingUpdate: (rating){
            reviewAndRatingProvider.setRating(rating.toString());
            }),
          
        ),
        SizedBox(height: 3.h,),
        customTextField('Your feedback',
        controller: _feedbackController),
        SizedBox(height: 3.h,),        
        CustomButton(onPressed: (){
          reviewAndRatingProvider.setReview(_feedbackController.text);
          addReview(_feedbackController.text, reviewAndRatingProvider.ratings);
          Navigator.of(context).pushNamed('/transfer');
        }, text: "Submit",size: 15.sp,),
        ],
          ),
        ),
      ),
    );
  }
}