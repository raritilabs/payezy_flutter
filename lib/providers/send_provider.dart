import 'package:flutter/material.dart';
import 'package:payezy/functions/truncate_to_decimal.dart';

enum SendPages{
  enterAmount,
  enterDetails,
}

class SendPageProvider with ChangeNotifier {

  //navigation initialisation

  SendPages _sendPage = SendPages.enterAmount;
  SendPages get sendPage => _sendPage;

  //text field values
   num _youSend=00.00;
num get youSend=>_youSend;
num _youReceive=00.00;
num get youReceive=>_youReceive;

bool _expanded=false;
bool get expanded=>_expanded;


//validation message initialisation

bool _noValueValidationMessage=false; //turns true when no value is typed
bool get noValueValidationMessage=>_noValueValidationMessage;
bool _maxValueValidationMessage=false; //turns true when value exceeds 2000
bool get maxValueValidationMessage=>_maxValueValidationMessage;

//top button selection initialisation

bool _bankIsSelected=true;
bool get bankIsSelected=>_bankIsSelected;

bool _cardIsSelected=false;
bool get cardIsSelected=>_cardIsSelected;


//Bank Transfer expanded details initialisation

num _bankTransferCharge=00.00;
num get bankTransferCharge=>_bankTransferCharge;
num _totalCharges=00.00;
num get totalCharges=>_totalCharges;
num _amountExchanged=00.00;
num get amountExchanged=>_amountExchanged;
 num _effectiveMidMarketRate=00.00;
 num get effectiveMidMarketRate=> _effectiveMidMarketRate;
//card payment expanded details initialisation


num _cardTransferCharge=00.00;
num get cardTransferCharge=>_cardTransferCharge;
num _cardAmountExchanged=00.00;
num get cardAmountExchanged=>_cardAmountExchanged;
double _exchangeRate=0.0;
double get exchangeRate=>_exchangeRate;

  void setSendPage(SendPages sendPage)
  {
    _sendPage=sendPage;
    notifyListeners();
  }

  void setExchangeRate(double rate) async
  {
    _exchangeRate=rate;
  }

  void setSendAmount(String value){

  
       _noValueValidationMessage=false;
    _maxValueValidationMessage=false;
  _youSend = num.tryParse(value)??0;
  
  //bank transfer calculations
 _bankTransferCharge=(_youSend*0.008);
if(_bankTransferCharge>5)
{
  _bankTransferCharge=5;
}
 
  num _payezyPlatformfees=00.00;
  _totalCharges=_bankTransferCharge+_payezyPlatformfees;
  _amountExchanged=_youSend - _totalCharges;

  //card transfer calculations1
  _cardTransferCharge=(_youSend*0.04);
  _cardAmountExchanged=_youSend-_cardTransferCharge;

if(_bankIsSelected==true){
_youReceive=(_amountExchanged*_exchangeRate).truncateToDecimalPlaces(2);
}
else{
  _youReceive=(_cardAmountExchanged*_exchangeRate).truncateToDecimalPlaces(2);

}
 
 _effectiveMidMarketRate=(_youReceive/_youSend).truncateToDecimalPlaces(2);

  _expanded=true;
   notifyListeners();
   
  }
  
  void setnoValueValidationMessage(){
    _noValueValidationMessage=true;
    notifyListeners();
 }

  void setmaxValueValidationMessage(){
    _maxValueValidationMessage=true;
    notifyListeners();
 }

 void setBankIsSelected(){
  _bankIsSelected=true;
    _cardIsSelected=false;
notifyListeners();
 }

 void setCardIsSelected(){
  _cardIsSelected=true;
  _bankIsSelected=false;
 notifyListeners();
 }
  }

    
 

