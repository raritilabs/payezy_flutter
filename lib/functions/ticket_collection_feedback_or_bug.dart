import "dart:developer";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void addBugorFeedbackReport(String message, String ticketreply, String ticketstatus,String tickettype) async{

CollectionReference ticketCollection = FirebaseFirestore.instance.collection('ticketCollection');
String transferId = FirebaseFirestore.instance.collection('ticketCollection').doc().id;
String? email=FirebaseAuth.instance.currentUser!.email;
    
    Map<String, dynamic> ticketCollectionDetails = {
    "message":message,
    "ticketReply":ticketreply,
    "ticketStatus":ticketstatus,
    "ticketType":tickettype,
    };

    ticketCollection
    .doc(email)
    .collection('ticketList')
    .doc(transferId)
    .set(ticketCollectionDetails)
     .then((value) => log('Inserted bug report/feedback'))
     .catchError((error) => log('Failed to insert bug report/feedback: $error'));
  }