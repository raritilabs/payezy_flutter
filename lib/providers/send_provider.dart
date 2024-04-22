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
num _youReceiveBank=00.00;
num get youReceiveBank=>_youReceiveBank;

num _youReceiveCard=00.00;
num get youReceiveCard=>_youReceiveCard;

bool _expanded=false;
bool get expanded=>_expanded;


//validation message initialisation

bool _noValueValidationMessage=false; //turns true when no value is typed
bool get noValueValidationMessage=>_noValueValidationMessage;
bool _maxValueValidationMessage=false; //turns true when value exceeds maxAllowed value
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
 num _effectiveMidMarketRateBank=00.00;
 num get effectiveMidMarketRateBank=> _effectiveMidMarketRateBank;

//card payment expanded details initialisation

num _cardTransferCharge=00.00;
num get cardTransferCharge=>_cardTransferCharge;
num _cardAmountExchanged=00.00;
num get cardAmountExchanged=>_cardAmountExchanged;
double _exchangeRate=0.0;
double get exchangeRate=>_exchangeRate;
double _treasuryBalance=0.0;
double get treasuryBalance=>_treasuryBalance;

 num _effectiveMidMarketRateCard=00.00;
 num get effectiveMidMarketRateCard=> _effectiveMidMarketRateCard;

 //time
 String _currentTime='';
 String get time=>_currentTime;

  void setSendPage(SendPages sendPage)
  {
    _sendPage=sendPage;
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
  void setExchangeRate(double rate) 
  {
    _exchangeRate=rate;
    notifyListeners();
  }

  void setSendAmount(String value){  
  _noValueValidationMessage=false; //when typing validation msg is set to false
  _maxValueValidationMessage=false;//maximum value validation msg set to false while typing
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
_youReceiveBank=(_amountExchanged*_exchangeRate).truncateToDecimalPlaces(2);
_effectiveMidMarketRateBank=(_youReceiveBank/_youSend).truncateToDecimalPlaces(2); 
  //card transfer calculations
_cardTransferCharge=(_youSend*0.04);
_cardAmountExchanged=_youSend-_cardTransferCharge;
_youReceiveCard=(_cardAmountExchanged*_exchangeRate).truncateToDecimalPlaces(2);
_effectiveMidMarketRateCard=(_youReceiveCard/_youSend).truncateToDecimalPlaces(2); 
notifyListeners();
}

//set expanded 
//
void setExpanded(bool value){
  _expanded=value;
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

  void setTreasuryBalance(double balance) async
  {
    _treasuryBalance=balance; 
    notifyListeners();
  }
 
  void setCurrentTime(time) 
  {
    _currentTime=time;
    notifyListeners;
    
  }
   }
