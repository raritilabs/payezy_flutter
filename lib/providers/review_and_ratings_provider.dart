import 'package:flutter/material.dart';

class ReviewAndRatingsProvider extends ChangeNotifier{
  //initialise review
String _review='';
String get review=>_review;

//initialise rating
String _ratings='';
String get ratings=>_ratings;

  void setReview(review)
  {
    _review=review;
    notifyListeners();
  }
  void setRating(ratings){
    _ratings=ratings;
    notifyListeners();
  }
  void reset(){
  _review='';  
  _ratings='';
  notifyListeners();
  }
}