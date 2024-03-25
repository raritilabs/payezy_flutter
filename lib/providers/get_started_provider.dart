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
String _user='';
String get user=>_user;
String _useremail='';
String get useremail=>_useremail;

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
void setUser(name,email){
_user=name;
_useremail=email;
notifyListeners();
}

}
