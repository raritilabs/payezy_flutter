 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addData(String fname, int phone, int bankaccnum, Object ifsc) async {
    if (fname == "" && phone == 0 && bankaccnum == 0 && ifsc == 0) {
      const Text('Enter Required Fields');
    } else {
      FirebaseFirestore.instance.collection('Users').doc(fname).set({
        "First Name": fname,
        "Phone": phone,
        "Bank Acc Number": bankaccnum,
        "IFSC Code": ifsc,
      }).then((value) => print('inserted'));
    }
  }