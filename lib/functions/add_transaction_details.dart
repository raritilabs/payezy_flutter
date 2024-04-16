import 'package:cloud_firestore/cloud_firestore.dart';


  addTransactionDetails(String inrAmount, String usdAmount, String timeOfTransaction, String email, String ifsc,String phone, String accountNumber) async{
        String transferId = FirebaseFirestore.instance.collection('transferHistory').doc().id;

    FirebaseFirestore.instance.collection('transferHistory').doc(email).set({
      "INR Amount":inrAmount,
      "USD Amount":usdAmount,
      "Time":timeOfTransaction,
      "Email":email,
      "Transfer ID":transferId,
      "IFSC":ifsc,
      "Phone":phone,
      "Account Number":accountNumber,
      
    });
  }