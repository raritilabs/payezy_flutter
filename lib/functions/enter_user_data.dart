 import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addUserData(String kyc, String email, String firstname, String lastname, int phonenumber, Object stripecustomerid,String providerid) async {
    if (kyc == "" && email == '' && firstname == '' && lastname == ''&& phonenumber==0 && stripecustomerid==0 && providerid=='') {
      const Text('Enter Required Fields');
    } else {
      FirebaseFirestore.instance.collection('userData').doc(email).set({
        "KYCStatus": kyc,
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "phoneNumber": phonenumber,
        "stripeCustomerId": stripecustomerid,
        "providerId": providerid,
      });
    }
  }