import 'package:flutter/material.dart';

class GetStartedProvider extends ChangeNotifier{
 
 String _email='';
String get email=>_email;
String _password='';
String get password=>_password;

void setEmail(String value){
  _email = value;
  notifyListeners();
}  

void setPassword(String value){
  _password = value;
  notifyListeners();
}  

}
