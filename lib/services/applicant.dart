// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Applicant {
  CollectionReference applicant =
      FirebaseFirestore.instance.collection('Applicant');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> apply(
    String companyid,
    String fname,
    String lname,
    String email,
    String image,
    String address,
    String number,
    String sex,
    String birthday,
    List<dynamic> skills,
    List<dynamic> experience,
  ) async {
    return await applicant
        .add({
          "email": email,
          "firstname": fname,
          "lastname": lname,
          "image": image,
          "address": address,
          "birthday": birthday,
          "gender": sex,
          "phoneNumber": number,
          "skills": skills,
          "experience": experience,
          "companyid": companyid,
        })
        .then((value) => print("data Added"))
        .catchError((error) => print("data couldn't be added."));
  }
}
