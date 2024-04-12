import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;


Future getUserTransactionHistory() async {
  String url = "https://dev-server.payezy.io/get-user-transaction-history";

  try {

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User not logged in, handle this case
      return "User not logged in";
    }
    String? email=FirebaseAuth.instance.currentUser?.email;
    String? idToken = await user.getIdToken();

     Map<String, dynamic> transferDetails = {
      "email": email,
    };


   Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $idToken',
    };
    var response = await http.post(Uri.parse(url), headers: headers,body:jsonEncode(transferDetails) );

    if (response.statusCode == 200) {
          log(response.body);
    return response.body;
    } else {
      // Handle error response here
      log( 'Request failed with status: ${response.statusCode}');
      return 'Request failed with status: ${response.statusCode}';
    }
  } catch (e) {
    // Handle exception if any
    log( 'Exception during HTTP request: $e');
    return 'Exception during HTTP request: $e';
  }
}
