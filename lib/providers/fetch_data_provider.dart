import 'package:flutter/material.dart';

class FetchDataProvider extends ChangeNotifier{

   bool _visibility=true;
bool get visibility=>_visibility;

void isVisible(){
_visibility=!_visibility;
notifyListeners();
}
}