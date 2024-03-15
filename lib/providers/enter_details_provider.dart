
import 'package:flutter/material.dart';

class EnterDetailsProvider extends ChangeNotifier{
 
 String _fName='';
String get fname=>_fName;

int _phone=0;
int get phone=>_phone;

int _bAccountNumber=0;
int get bAccountNumber=>_bAccountNumber;

Object _iFSC=0;
Object get iFSC=>_iFSC;

void setfName(String value){
  _fName = value;
  notifyListeners();
}
void setPhone(int value){
  _phone= value;
  notifyListeners();
}
void setBankAccNum(int value){
  _bAccountNumber = value;
  notifyListeners();
}  
void setiFSC(Object value){
  _iFSC = value;
  notifyListeners();
}
}
