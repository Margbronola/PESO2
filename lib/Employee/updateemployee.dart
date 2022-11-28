// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peso/services/addingUser.dart';

class UpdateEmployeePage extends StatefulWidget {
  const UpdateEmployeePage({super.key});

  @override
  State<UpdateEmployeePage> createState() => _UpdateEmployeePageState();
}

class _UpdateEmployeePageState extends State<UpdateEmployeePage> {
  late final TextEditingController address;
  late final TextEditingController birthdate;
  late final TextEditingController number;
  late final TextEditingController _skills;
  late final TextEditingController _experience;
  late final TextEditingController interestedjob;
  late final TextEditingController elem;
  late final TextEditingController elemgrad;
  late final TextEditingController highschool;
  late final TextEditingController hsgrad;
  late final TextEditingController college;
  late final TextEditingController collegegrad;
  late final TextEditingController religion;
  late final TextEditingController age;
  late final TextEditingController civilstatus;

  final ImagePicker _picker = ImagePicker();
  String gender = "";
  var imageFile;
  bool isloading = false;
  late String imageUrl;

  @override
  void initState() {
    address = TextEditingController();
    birthdate = TextEditingController();
    number = TextEditingController();
    _skills = TextEditingController();
    _experience = TextEditingController();
    interestedjob = TextEditingController();
    elem = TextEditingController();
    elemgrad = TextEditingController();
    highschool = TextEditingController();
    hsgrad = TextEditingController();
    college = TextEditingController();
    collegegrad = TextEditingController();
    religion = TextEditingController();
    age = TextEditingController();
    civilstatus = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    birthdate.dispose();
    number.dispose();
    _skills.dispose();
    _experience.dispose();
    interestedjob.dispose();
    elem.dispose();
    elem.dispose();
    highschool.dispose();
    hsgrad.dispose();
    college.dispose();
    collegegrad.dispose();
    religion.dispose();
    age.dispose();
    civilstatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyWidget().text(
                        label: "Profile",
                        weight: FontWeight.bold,
                        size: 17,
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: imageFile == null
                            ? PopupMenuButton(
                                offset: const Offset(0, 50),
                                onSelected: (val) => val == 'cam'
                                    ? _getFromCamera()
                                    : _getFromGallery(),
                                itemBuilder: (_) => <PopupMenuItem<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'cam',
                                    child: Text('Camera'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'gal',
                                    child: Text('Gallery'),
                                  ),
                                ],
                                child: const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                              )
                            : Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MyWidget().text(
                    label: "Personal Information",
                    weight: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  MyWidget().text(label: "Address : "),
                  MyWidget().textFormField2(
                      align: TextAlign.right, controller: address),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Birthday : "),
                      Expanded(
                          child: Container(
                              height: 40,
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller: birthdate,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 7),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)))!;
                                  birthdate.text =
                                      DateFormat("yyyy-MM-dd").format(date);
                                },
                              ))),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Age : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: age, keyboardType: TextInputType.number),
                      )),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Gender : "),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 100,
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Male"),
                          value: "Male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Female"),
                          value: "Female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Civil Status : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: civilstatus),
                      )),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Phone No. : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: number, keyboardType: TextInputType.number),
                      )),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Religion : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: religion),
                      )),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      MyWidget().text(label: "Desired Position : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: interestedjob),
                      )),
                    ],
                  ),
                  const SizedBox(height: 25),
                  MyWidget().text(
                    label: "Skills",
                    weight: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: 5,
                    controller: _skills,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 7),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyWidget().text(
                    label: "Educational Attainment",
                    weight: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      MyWidget().text(label: "Elementary : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: elem),
                      )),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      MyWidget().text(label: "School Year : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: elemgrad),
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      MyWidget().text(label: "High School : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: highschool),
                      )),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      MyWidget().text(label: "School Year : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: hsgrad),
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      MyWidget().text(label: "College : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: college),
                      )),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      MyWidget().text(label: "School Year : "),
                      Expanded(
                          child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10),
                        child: MyWidget().textFormField2(
                            align: TextAlign.right, controller: collegegrad),
                      )),
                    ],
                  ),
                  const SizedBox(height: 25),
                  MyWidget().text(
                    label: "Work Experience",
                    weight: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: 5,
                    controller: _experience,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 7),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final List<String> skills =
                                    _skills.text.split("\n");
                                final List<String> experience =
                                    _experience.text.split("\n");
                                setState(() {
                                  isloading = true;
                                });
                                if (address.text.isEmpty &&
                                    birthdate.text.isEmpty &&
                                    gender == "" &&
                                    number.text.isEmpty &&
                                    _skills.text.isEmpty &&
                                    _experience.text.isEmpty &&
                                    interestedjob.text.isEmpty && age.text.isEmpty && religion.text.isEmpty && civilstatus.text.isEmpty && elem.text.isEmpty && elemgrad.text.isEmpty && highschool.text.isEmpty && hsgrad.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Fill all fields");
                                  setState(() {
                                    isloading = false;
                                  });
                                } else {
                                  UpdateData().updateEmployee(
                                      uid,
                                      address.text,
                                      birthdate.text,
                                      gender,
                                      number.text,
                                      interestedjob.text,
                                      skills,
                                      experience,
                                      elem.text,
                                      elemgrad.text,
                                      highschool.text,
                                      hsgrad.text,
                                      college.text,
                                      collegegrad.text,
                                      religion.text,
                                      age.text,
                                      civilstatus.text);
                                  UpdateData()
                                      .uploadImage(imageFile)
                                      .then((value) async {
                                    if (value != null) {
                                      await UpdateData()
                                          .updateUserImage(uid, value);
                                    }
                                  }).whenComplete(() {
                                    setState(() {
                                      isloading = false;
                                    });

                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: MyWidget().text(
                                  label: "SAVE",
                                  letterSpacing: 2,
                                  weight: FontWeight.bold,
                                  color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black26,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: MyWidget().text(
                                  label: "CANCEL",
                                  letterSpacing: 2,
                                  weight: FontWeight.bold,
                                  color: Colors.grey.shade700)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            isloading ? MyWidget().loader() : Container(),
          ],
        ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      imageFile = File(image!.path);
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      imageFile = File(image!.path);
    });
  }
}
