import 'dart:convert';
import 'package:http/http.dart' as http;


Future<double> getInrTreasuryBalance() async {


String url="https://dev-server.payezy.io/get-inr-treasury-balance";

try{
   var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String,dynamic>jsonResponse =json.decode(response.body);
    double getInrTreasuryBalance=jsonResponse["get-inr-treasury-balance"];
    return getInrTreasuryBalance;
  } else {
    throw Exception('Failed to fetch data');
  }
  
}
catch(e){
  throw Exception("Error fetching data:$e");
}
}