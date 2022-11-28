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
    String jobId,
    List<dynamic> skills,
    List<dynamic> experience,
    String interestedjob,
    String elem,
    String eyg,
    String highschool,
    String hsyg,
    String? college,
    String? cyg,
    String religion,
    String age, 
    String civilstatus,
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
          "jobId": jobId,
          "desiredPosition": interestedjob,
          "Elementary": elem,
          "ElemSchoolYear": eyg,
          "HighSchool": highschool,
          "HSSchoolYear": hsyg,
          "College": college,
          "CollegeSchoolYear": cyg,
          "Religion" : religion,
          "Age" : age,
          "CivilStatus" : civilstatus
        })
        .then((value) => print("data Added"))
        .catchError((error) => print("data couldn't be added."));
  }
}
