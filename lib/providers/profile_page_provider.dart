import 'package:flutter/material.dart';

enum ProfilePages{
  createticket,
  failedtransaction,
  helpandsupport,
  feedbackorbug
}

enum ChooseButton{
  failedtransaction,
  feedbackorbug
}

class ProfilePageProvider with ChangeNotifier {

  //navigation initialisation

  ProfilePages _profilePage = ProfilePages.helpandsupport;
  ProfilePages get profilePage => _profilePage;

 //setting the page as new page
 void setProfilePage(ProfilePages profilePage)
  {
    _profilePage=profilePage;
    notifyListeners();
  }
  
  //radio button selection
   ChooseButton _chooseButton=ChooseButton.failedtransaction;
   ChooseButton get chooseButton=>_chooseButton;

  void setChooseButton(ChooseButton chooseButton)
  {
    _chooseButton=chooseButton;
    notifyListeners();
  }

  String _orderId='';
  String get orderId=>_orderId;

  void setOrderId(value){
_orderId=value;
notifyListeners();
  }
   }
