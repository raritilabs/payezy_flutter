import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;
double _treasuryBalance=0.0;
double get treasuryBalance =>_treasuryBalance;

Future<double> getInrTreasuryBalance() async {

String url="https://dev-server.payezy.io/";
 

try{
  String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
  
    Map<String,String> headers= {
      "Content-Type" : "application/json",
      'Authorization':'Bearer $idToken',
    };
   // print(headers);
    var response = await http.get(Uri.parse("${url}get-inr-treasury-balance"),
    headers:headers
     );  
 if (response.statusCode==200) {
// Handling successful response here
//var jsonResponse = json.decode(response.body);
      devtools.log('json response in ${response.body}');
//   _treasuryBalance=double.parse(jsonResponse);
// Process the response data
//       print(_treasuryBalance);
     return _treasuryBalance;
    } else {
      // Handle error response here
   devtools.log('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception if any
    devtools.log('Exception during HTTP request: $e');
  }
return _treasuryBalance;
}