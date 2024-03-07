import 'package:flutter/material.dart';

enum SendPage{
  enterAmount,
  enterDetails,
}

class SendPageProvider with ChangeNotifier {

  SendPage _sendPage = SendPage.enterAmount;
  SendPage get sendPage => _sendPage;
   num _youSend=0;
num get youSend=>_youSend;
num _youReceive=0;
num get youReceive=>_youReceive;
bool _expanded=false;
bool get expanded=>_expanded;


  void setSendPage(SendPage sendPage)
  {
    _sendPage=sendPage;
    notifyListeners();
  }

  void setSendAmount(String value){
  _youSend = int.parse(value);
  _youReceive=_youSend*82.54;
  _expanded=true;
  notifyListeners();
} 
}