// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateData {
  CollectionReference user = FirebaseFirestore.instance.collection('User');
  CollectionReference company =
      FirebaseFirestore.instance.collection('Company');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateEmployee(
    uid,
    String address,
    String birthday,
    String gender,
    String number,
    String interestedjob,
    List<String> skills,
    List<String> experience,
    String elem,
    String eyg,
    String highschool,
    String hsyg,
    String college,
    String cyg,
    String religion,
    String age, 
    String civilstatus,
  ) async {
    return await user
        .doc(uid)
        .update({
          "address": address,
          "birthday": birthday,
          "gender": gender,
          "phoneNumber": number,
          "skills": skills,
          "experience": experience,
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

  Future<String?> uploadImage(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("$mFileImage");

    TaskSnapshot taskSnapshot = await storageReference.putFile(mFileImage);

    var downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  Future<String?> uploadprofile(pFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("$pFileImage");

    TaskSnapshot taskSnapshot = await storageReference.putFile(pFileImage);

    var downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  updateUserImage(uid, url) async {
    await user.doc(uid).update({"image": url});
  }

  Future<void> updateCompany(uid, String address, String telno) async {
    return await company
        .doc(uid)
        .update({
          "address": address,
          "Telephone": telno,
        })
        .then((value) => print("data Added"))
        .catchError((error) => print("data couldn't be added."));
  }

  updateCompanyMap(uid, url) async {
    await company.doc(uid).update({"map": url});
  }

  updateCompanyProfile(uid, url) async {
    await company.doc(uid).update({"image": url});
  }
}
