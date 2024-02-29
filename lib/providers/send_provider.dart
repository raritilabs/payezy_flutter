import 'package:flutter/material.dart';

enum SendPage{
  enterAmount,
  enterDetails,
}

class SendPageProvider with ChangeNotifier {

  SendPage _sendPage = SendPage.enterAmount;
  SendPage get sendPage => _sendPage;

  void setSendPage(SendPage sendPage)
  {
    _sendPage=sendPage;
    notifyListeners();
  }
}