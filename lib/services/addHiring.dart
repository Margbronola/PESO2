// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peso/global/container.dart';

class Hiring {
  CollectionReference joboffer =
      FirebaseFirestore.instance.collection('JobOffer');
  CollectionReference company = FirebaseFirestore.instance
      .collection('Company')
      .doc(uid)
      .collection('Hiring');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> add(uid, String position, String description,
      List<String> qualification) async {
    return await company
        .add({
          "position": position,
          "description": description,
          "qualification": qualification,
        })
        .then((value) => print("data Added"))
        .catchError((error) => print("data couldn't be added."));
  }

  Future<void> addjobOffer(
    String uid,
    String name,
    String email,
    String image,
    String address,
    String telno,
    String position,
    String description,
    String map,
    List<String> qualification,
  ) async {
    return await joboffer
        .add({
          "uid": uid,
          "companyName": name,
          "email": email,
          "image": image,
          "address": address,
          "telephone": telno,
          "position": position,
          "description": description,
          "qualification": qualification,
          "map": map,
        })
        .then((value) => print("data Added"))
        .catchError((error) => print("data couldn't be added."));
  }
}
