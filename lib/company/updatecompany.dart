// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/services/addingUser.dart';

class UpdateCompanyPage extends StatefulWidget {
  const UpdateCompanyPage({super.key});

  @override
  State<UpdateCompanyPage> createState() => _UpdateCompanyPageState();
}

class _UpdateCompanyPageState extends State<UpdateCompanyPage> {
  late final TextEditingController address;
  late final TextEditingController telNo;
  late final TextEditingController map;
  bool isloading = false;
  final ImagePicker _picker = ImagePicker();
  var mapFile;
  var profileFile;

  @override
  void initState() {
    address = TextEditingController();
    map = TextEditingController();
    telNo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Company Details",
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                      child: profileFile == null
                          ? PopupMenuButton(
                              offset: const Offset(0, 50),
                              onSelected: (val) => val == 'cam'
                                  ? _getFromCamera1()
                                  : _getFromGallery1(),
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
                              profileFile,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyWidget().text(
                  label: "Company Information",
                  weight: FontWeight.bold,
                  size: 17,
                ),
                const SizedBox(height: 15),
                MyWidget().text(label: "Address : "),
                MyWidget().textFormField2(controller: address, maxline: 2),
                const SizedBox(height: 15),
                Row(
                  children: [
                    MyWidget().text(label: "Tel. No. : "),
                    const SizedBox(width: 15),
                    Expanded(
                      child: MyWidget()
                          .textFormField2(controller: telNo, maxline: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidget().text(label: "Map : "),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: PopupMenuButton(
                        offset: const Offset(0, 40),
                        onSelected: (val) =>
                            val == 'cam' ? _getFromCamera() : _getFromGallery(),
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                mapFile == null
                    ? Container()
                    : SizedBox(
                        height: 200,
                        child: Image.file(
                          mapFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55,
                        margin: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isloading = true;
                              });
                              if (address.text.isEmpty &&
                                  telNo.text.isEmpty &&
                                  map.text.isEmpty) {
                                Fluttertoast.showToast(msg: "Fill all fields");
                                setState(() {
                                  isloading = false;
                                });
                              } else {
                                UpdateData().updateCompany(
                                  uid,
                                  address.text,
                                  telNo.text,
                                );
                                UpdateData()
                                    .uploadprofile(profileFile)
                                    .then((value) async {
                                  print("PROFILE: $value");
                                  if (value != null) {
                                    await UpdateData()
                                        .updateCompanyProfile(uid, value);
                                  }
                                });
                                UpdateData()
                                    .uploadImage(mapFile)
                                    .then((value) async {
                                  print("MAP: $value");
                                  if (value != null) {
                                    await UpdateData()
                                        .updateCompanyMap(uid, value);
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
          isloading ? MyWidget().loader() : Container()
        ],
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
      mapFile = File(image!.path);
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      mapFile = File(image!.path);
    });
  }

  /// Get from gallery
  _getFromGallery1() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      profileFile = File(image!.path);
    });
  }

  /// Get from Camera
  _getFromCamera1() async {
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      profileFile = File(image!.path);
    });
  }
}
