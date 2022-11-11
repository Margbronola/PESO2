// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication{
    static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> create({required String email, required String password}) async {
    try {
      UserCredential creds = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (creds.user == null) return null;
      print("CRED USER: ${creds.user}");
      return await creds.user!.getIdToken();
    } 
    catch (e){
      return null;
    }
  }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user == null) return null;
      return authResult.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Account not found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Incorrect password");
      } else if (e.code == "") {}
      return null;
    }
  }
}