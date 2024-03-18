import 'package:flutter/material.dart';

enum SendPages{
  enterAmount,
  enterDetails,
}

class SendPageProvider with ChangeNotifier {

  SendPages _sendPage = SendPages.enterAmount;
  SendPages get sendPage => _sendPage;
   num _youSend=00.00;
num get youSend=>_youSend;
num _youReceive=00.00;
num get youReceive=>_youReceive;
bool _expanded=false;
bool get expanded=>_expanded;
bool _noValueValidationMessage=false; //turns true when no value is typed
bool get noValueValidationMessage=>_noValueValidationMessage;
bool _maxValueValidationMessage=false; //turns true when value exceeds 2000
bool get maxValueValidationMessage=>_maxValueValidationMessage;


  void setSendPage(SendPages sendPage)
  {
    _sendPage=sendPage;
    notifyListeners();
  }

  void setSendAmount(String value){
    _noValueValidationMessage=false;
    _maxValueValidationMessage=false;
  _youSend = num.parse(value);
  _youReceive=_youSend*82.54;
  _expanded=true;
   notifyListeners();
  }
  
  void setnoValueValidationMessage(){
    _noValueValidationMessage=true;
    notifyListeners();
 }

  void setmaxValueValidationMessage(){
    _maxValueValidationMessage=true;
    notifyListeners();
 }
  }

    
 

