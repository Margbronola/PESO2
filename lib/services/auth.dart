// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/datacacher.dart';
import 'package:peso/model/user.dart';

class Authentication {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  final DataCacher cacher = DataCacher.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('User');
  CollectionReference company =
      FirebaseFirestore.instance.collection('Company');
  Future<String?> createCompany(
      {required String email,
      required String password,
      required String name,
      required String page}) async {
    try {
      UserCredential creds = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (creds.user == null) return null;
      cacher.token = "${creds.user!.getIdToken()}";
      cacher.uid = creds.user!.uid;
      cacher.pages = page;
      uid = creds.user!.uid;
      company.doc(creds.user!.uid).set({
        "email": email,
        "companyname": name,
        "address": null,
        "map": null,
        "Telephone": null,
        "image": null,
      });
      return await creds.user!.getIdToken();
    } catch (e) {
      return null;
    }
  }

  Future<String?> createEmployee(
      {required String email,
      required String password,
      required String fname,
      required String lname,
      required String page}) async {
    try {
      UserCredential creds = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (creds.user == null) return null;
      cacher.token = "${creds.user!.getIdToken()}";
      cacher.uid = creds.user!.uid;
      cacher.pages = page;
      uid = creds.user!.uid;
      user.doc(creds.user!.uid).set({
        "email": email,
        "firstname": fname,
        "lastname": lname,
        "image": null,
        "address": null,
        "birthday": null,
        "gender": null,
        "phoneNumber": null,
        "skills": null,
        "experience": null,
      });
      return await creds.user!.getIdToken();
    } catch (e) {
      return null;
    }
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required String page}) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user == null) return null;
      cacher.token = "${authResult.user!.getIdToken()}";
      cacher.pages = page;
      cacher.uid = authResult.user!.uid;
      uid = authResult.user!.uid;
      return authResult.user!.getIdToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Account not found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Incorrect password");
      } else if (e.code == "") {}
      return null;
    }
  }

  Future<void> signout() async {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      return;
    }
  }
}
