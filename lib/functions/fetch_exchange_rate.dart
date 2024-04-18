import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


Future<double> fetchExchangeRate() async {


String url='${dotenv.env['BACKEND_SERVER_URL']}';

try{
   var response = await http.get(Uri.parse("$url/get-usdinr-rate"));
  if (response.statusCode == 200) {
    Map<String,dynamic>jsonResponse =json.decode(response.body);
    double usdToInr=jsonResponse["UsdToInr"];
    return usdToInr;
  } else {
    throw Exception('Failed to fetch data');
  }
  
}
catch(e){
  throw Exception("Error fetching data:$e");
}
}