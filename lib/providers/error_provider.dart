import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier{
  //initialise error
String _error='';
String get error=>_error;

//initialise error visibility
bool _errorVisibility=false;
bool get errorVisibility=>_errorVisibility;

  void setError(error)
  {
    _error=error;
    notifyListeners();
  }
  void setErrorVisibility(){
    _errorVisibility=true;
    notifyListeners();
  }
  void reset(){
  _errorVisibility=false;  
  _error='';
  notifyListeners();
  }
}