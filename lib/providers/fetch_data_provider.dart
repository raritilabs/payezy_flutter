import 'package:flutter/material.dart';

enum TransferPages{
transferhistory,
transferissue,
}
  //navigation initialisation

class FetchDataProvider extends ChangeNotifier {
  List<bool> _visibility = [];
 TransferPages _transferPage = TransferPages.transferhistory;
  TransferPages get transferPage => _transferPage;
//setting the page
 void setTransferPage(TransferPages transferPage)
  {
    _transferPage=transferPage;
    notifyListeners();
  }  

  // Method to initialize visibility list with a given count
  void initializeVisibility(int count) {
    _visibility = List.generate(count, (index) => false);
  }

  // Method to toggle visibility at a specific index
  void toggleVisibility(int index) {
    _visibility[index] = !_visibility[index];
    
    notifyListeners(); // Notify listeners after toggling
  }

  // Getter method to access the visibility list
  List<bool> get visibility => _visibility;
}