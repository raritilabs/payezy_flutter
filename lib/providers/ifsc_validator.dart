import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:payezy/models/ifsc_model.dart';

class ApiProvider extends ChangeNotifier{


static  String _iFSC='';
static get iFSC=>_iFSC;
String _url='https://ifsc.razorpay.com/$iFSC';
String get url=>_url;

void setiFSC(String value){
// _iFSCValidationMessage=false;
 _iFSC = value;
  _url = 'https://ifsc.razorpay.com/$iFSC';
  notifyListeners();
}

//  static String url = 'https://ifsc.razorpay.com/$iFSC';

  bool isLoading = true;
  String error = '';
  IfscModel values = IfscModel( branch: '', city: '', bank: '', ifsc: '');
  
 
 getDataFromAPI() async{

  try{
   Response response=await http.get(Uri.parse(url));
   if(response.statusCode == 200){
    values= ifscModelFromJson(response.body);
    notifyListeners();
    return values;
   }
   else{
    error = response.statusCode.toString();
    notifyListeners();
    return error;
    
   }

  }
  catch(e){
    error=e.toString();

  }
  isLoading=false;
  notifyListeners();
}
}
