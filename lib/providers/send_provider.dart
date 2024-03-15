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


  void setSendPage(SendPages sendPage)
  {
    _sendPage=sendPage;
    notifyListeners();
  }

  void setSendAmount(String value){
  _youSend = num.parse(value);
  _youReceive=_youSend*82.54;
  _expanded=true;
  notifyListeners();
} 
}