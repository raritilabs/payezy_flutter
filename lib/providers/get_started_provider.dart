import 'package:flutter/material.dart';

class GetStartedProvider extends ChangeNotifier{
 
 String _email='';
String get email=>_email;
String _password='';
String get password=>_password;
String _confirmPassword='';
String get confirmPassword=>_confirmPassword;
bool _wrongPassword=false;
bool get wrongPassword=>_wrongPassword;

void setEmail(String value){
  _email = value;
  notifyListeners();
}  

void setPassword(String value){
    _wrongPassword=false;
  _password = value;
  notifyListeners();
}

void setConfirmPassword(String value){
      _wrongPassword=false;
  _confirmPassword=value;
  notifyListeners();
}

void setWrongPasswordValidation(){
  _wrongPassword=true;
  notifyListeners();
}

}
