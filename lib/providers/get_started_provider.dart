
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetStartedProvider extends ChangeNotifier{
 
//email/password sign in
//fetch email 
 String _email='';
String get email=>_email;
//fetch name
 String _name='';
String get name=>_name;
//fetch password
String _password='';
String get password=>_password;
//confirm password
String _confirmPassword='';
String get confirmPassword=>_confirmPassword;
bool _wrongPassword=false;
bool get wrongPassword=>_wrongPassword;
String _user='';
String get user=>_user;
String _useremail='';
String get useremail=>_useremail;
bool _isVisible=true;
bool get isVisible=>_isVisible;
late UserCredential _userCredentials;
UserCredential get userCredentials=>_userCredentials;
final String _type='';
String get type=>_type;
//setting error message

void setEmail(String value){
  _email = value;
  notifyListeners();
}  

void setName(String value){
  _name = value;
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
void resetUser(){
_user='';
_useremail='';
 _isVisible=true;
notifyListeners();
}
void setIsVisible(type){
  _isVisible=false;
  notifyListeners();
}
void setUserCredentials(user){
  _userCredentials=user;
  notifyListeners();
}





}
