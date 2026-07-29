 import 'package:firebase_auth/firebase_auth.dart';

 Future<String> getUserID() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }