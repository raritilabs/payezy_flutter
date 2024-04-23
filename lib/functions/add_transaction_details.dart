import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


  addTransactionDetails(String inrAmount, String usdAmount, String timeOfTransaction, String email, String ifsc,String phone, String accountNumber) async{
  String transferId = FirebaseFirestore.instance.collection('transferHistory').doc().id;
  CollectionReference transferHistoryCollection = FirebaseFirestore.instance.collection('transferHistory');

String? emailId=FirebaseAuth.instance.currentUser!.email;

    // Create a map for the account details
    Map<String, dynamic> transferDetails = {
      "INR Amount":inrAmount,
      "USD Amount":usdAmount,
      "Time":timeOfTransaction,
      "Email":email,
      "Transfer ID":transferId,
      "IFSC":ifsc,
      "Phone":phone,
      "Account Number":accountNumber,
    };  
      transferHistoryCollection
        .doc(emailId)
        .collection('transferHistory')
        .doc(transferId)
        .set(transferDetails)
        .then((value) => log('Inserted'))
        .catchError((error) => log('Failed to insert: $error'));  
  }