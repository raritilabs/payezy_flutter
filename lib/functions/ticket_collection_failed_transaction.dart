import "dart:developer";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void addFailedTransactionTicket(num timestamp, String message, String orderid, String ticketreply, String ticketstatus,String tickettype) async{

CollectionReference ticketCollection = FirebaseFirestore.instance.collection('ticketCollection');
String transferId = FirebaseFirestore.instance.collection('ticketCollection').doc().id;
String? email=FirebaseAuth.instance.currentUser!.email;
    
    Map<String, dynamic> ticketCollectionDetails = {
    "createdTimeStamp":timestamp,
    "message":message,
    "orderID":orderid,
    "ticketReply":ticketreply,
    "ticketStatus":ticketstatus,
    "ticketType":tickettype,
    };

    ticketCollection
    .doc(email)
    .collection('ticketList')
    .doc(transferId)
    .set(ticketCollectionDetails)
     .then((value) => log('Inserted failed transaction ticket'))
     .catchError((error) => log('Failed to insert failed transaction ticket: $error'));
  }