import 'package:flutter/material.dart';
enum LoginType{
  emailPassword,
  facebook,
  google,
  x,
}

class LoginProvider extends ChangeNotifier{

LoginType _loginType = LoginType.emailPassword;
LoginType get loginType=>_loginType;

void setLoginType(LoginType loginType){

_loginType=loginType;
notifyListeners();

}

}