import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

  addReview(String review,String rating){
    CollectionReference reviewAndRatings = FirebaseFirestore.instance.collection('ratingsAndReviews');
    String? email=FirebaseAuth.instance.currentUser?.email;
    String transferId=FirebaseFirestore.instance.collection('ratingsAndReviews').doc().id;

    Map<String, dynamic> reviewAndRating = {
      'review':review,
      'starRating':rating,
    };

    reviewAndRatings
    .doc(email)
    .collection('ratingsAndReviews')
    .doc(transferId)
    .set(reviewAndRating)
     .then((value) => log('Inserted failed transaction ticket'))
     .catchError((error) => log('Failed to insert failed transaction ticket: $error'));
  }
  