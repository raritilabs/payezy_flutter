
import 'package:flutter/material.dart';

enum ValidationMessage{
  initial,
  nicknameVM,
  fnameVM,
  phoneVM,
  emailVM,
  bAccountNumberVM,
  confirmAccountVM,
  iFSCVMError,
  iFSCVM
}

class EnterDetailsProvider extends ChangeNotifier{

  ValidationMessage _validationMessage = ValidationMessage.initial;
  ValidationMessage get validationMessage => _validationMessage;
bool _visibility=false;
bool get visiblity=>_visibility;

  bool _fnameValidationMessage=false;
  bool get fnameValidationMessage=>_fnameValidationMessage;
   bool _nickNameValidationMessage=false;
  bool get nickNameValidationMessage=>_nickNameValidationMessage;
     bool _phoneValidationMessage=false;
  bool get phoneValidationMessage=>_phoneValidationMessage;
   bool _emailValidationMessage=false;
  bool get emailValidationMessage=>_emailValidationMessage;
     bool _bAccountValidationMessage=false;
  bool get bAccountValidationMessage=>_bAccountValidationMessage;
     bool _confirmAccountValidationMessage=false;
  bool get confirmAccountValidationMessage=>_confirmAccountValidationMessage;
     bool _iFSCValidationMessage=false;
  bool get iFSCValidationMessage=>_iFSCValidationMessage;

 String _nickName='';
String get nickName=>_nickName;  
 
 String _fName='';
String get fname=>_fName;

int _phone=0;
int get phone=>_phone;

String _email='';
String get email=>_email;

int _bAccountNumber=0;
int get bAccountNumber=>_bAccountNumber;

int _confirmAccount=0;
int get confirmAccount=>_confirmAccount;

Object _iFSC='';
Object get iFSC=>_iFSC;

String _branch='';
String get branch=>_branch;

String _city='';
String get city=>_city;

String _bank='';
String get bank=>_bank;

void setfName(String value){
  _fnameValidationMessage=false;
  _fName = value;
  notifyListeners();
}
void setnickName(String value){
  _nickNameValidationMessage=false;
  _nickName = value;
  notifyListeners();
}
void setPhone(int value){
  _phoneValidationMessage=false;
  _phone= value;
  notifyListeners();
}

void setEmail(String value){
  _emailValidationMessage=false;
  _email= value;
  notifyListeners();
}

void setBankAccNum(int value){
  _bAccountValidationMessage=false;
  _bAccountNumber = value;
  notifyListeners();
}  
void setconfirmAcc(int value){
  _confirmAccountValidationMessage=false;
  _confirmAccount = value;
  notifyListeners();
}  
void setiFSC(Object value){
 _iFSCValidationMessage=false;
  _iFSC = value;
  notifyListeners();
}

void setIFSCDetails(String branch,String city,String bank){
 _branch=branch;
_city=city;
  _bank =bank;
  notifyListeners();
}

// void setfnameValidationMessage(){
//     _fnameValidationMessage=true;
//     notifyListeners();
//  }

//  void setphoneValidationMessage(){
//     _phoneValidationMessage=true;
//     notifyListeners();
//  }

 
//  void setbAccountValidationMessage(){
//     _bAccountValidationMessage=true;
//     notifyListeners();
//  }
//  void setconfirmAccountValidationMessage(){
//     _confirmAccountValidationMessage=true;
//     notifyListeners();
//  }
//  void setiFSCValidationMessage(){
//     _iFSCValidationMessage=true;
//     notifyListeners();
//  }

  void setValidationMessage(ValidationMessage validationMessage)
  {
    _validationMessage=validationMessage;
    notifyListeners();
  }

void setVisibility(bool value){
_visibility=value;
}
  
  }

