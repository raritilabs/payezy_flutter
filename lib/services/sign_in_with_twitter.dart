import 'package:firebase_auth/firebase_auth.dart';


Future<UserCredential> signInWithTwitter() async {
  TwitterAuthProvider twitterProvider = TwitterAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(twitterProvider);
}

