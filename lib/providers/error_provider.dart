import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier{
String _error='';
String get error=>_error;

  void setError(error)
  {
    _error=error;
    notifyListeners();
  }
}