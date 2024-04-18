import 'package:flutter/material.dart';

enum ProfilePages{
  createticket,
  exploredocs,
  helpandsupport,
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
  
   }
