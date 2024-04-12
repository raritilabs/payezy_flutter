import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addUserData(String kyc, String email, String firstname, String lastname, String phonenumber, Object stripecustomerid) async {
    if (kyc == "" && email == '' && firstname == '' && lastname == ''&& phonenumber=='' && stripecustomerid==0 ) {
      const Text('Enter Required Fields');
    } else {
      FirebaseFirestore.instance.collection('userData').doc(email).set({
        "KYCStatus": kyc,
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "phoneNumber": phonenumber,
        "stripeCustomerId": stripecustomerid,
      });
    }
  }