import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

String _treasuryBalance = '';
String get treasuryBalance => _treasuryBalance;

Future<double> getInrTreasuryBalance() async {
  String url='${dotenv.env['BACKEND_SERVER_URL']}';

  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      devtools.log("User not logged in");
      // User not logged in, handle this case
      return 0;
    }
    String? idToken = await user.getIdToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $idToken',
    };

    var response = await http.get(Uri.parse("$url/get-inr-treasury-balance"), headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      int balanceAmount = jsonResponse['balanceAmount'];
      int balanceDecimals = jsonResponse['balanceDecimals'];

      _treasuryBalance = (balanceAmount/pow(10, balanceDecimals)).toString();
      return double.parse(_treasuryBalance);
    } else {
      devtools.log('Request failed with status: ${response.statusCode}');
      // Handle error response here
      return 0;
    }
  } catch (e) {
    // Handle exception if any
    devtools.log('Exception during HTTP request: $e');
    return 0;
  }
}
