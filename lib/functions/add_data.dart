import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addData(String ifsc, String accountNumber, String email, String fullName, String nickName, String phoneNumber) async {
  // Reference to the 'userData' collection
  CollectionReference userDataCollection = FirebaseFirestore.instance.collection('userData');

  // Check if all required fields are filled
  if (ifsc == "" || accountNumber == '' || email == '' || fullName == '' || nickName == '' || phoneNumber == '') {
    // Display an error message if any field is missing
    log('Enter Required Fields');
  } else {
    // Generate a random ID for the account details
    String randomId = FirebaseFirestore.instance.collection('userData').doc().id;
String? emailId=FirebaseAuth.instance.currentUser!.email;
    // Create a map for the account details
    Map<String, dynamic> accountDetails = {
      "IFSCCode": ifsc,
      "accountNumber": accountNumber,
      "email": email,
      "fullName": fullName,
      "nickName": nickName,
      "phoneNumber": phoneNumber,
    };

    // Add account details to Firestore
    userDataCollection
        .doc(emailId)
        .collection('accountDetails')
        .doc(randomId)
        .set(accountDetails)
        .then((value) => log('Inserted'))
        .catchError((error) => log('Failed to insert: $error'));
  }
}
