// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peso/global/widget.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late final TextEditingController address = TextEditingController();
  late final TextEditingController birthdate = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var imageFile;
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.black,
        //   elevation: 0,
        // ),
        body: Container(
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
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: imageFile == null ? PopupMenuButton(
                      offset: const Offset(0, 50),
                      onSelected: (val) => val == 'cam' ? _getFromCamera() : _getFromGallery(),
                      itemBuilder: (_) =>
                      <PopupMenuItem<String>>[
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
                    ) : Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  )
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
              MyWidget().textFormField2(align: TextAlign.right),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 7),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), 
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), 
                          ),
                        ),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          FocusScope.of(context).requestFocus(FocusNode());
                          date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)
                          ))!;
                          birthdate.text = DateFormat("yyyy-MM-dd").format(date);
                        },
                      )
                    )
                  ),
                ],
              ),
              const Divider(color: Colors.transparent),
              Row(
                children: [
                  MyWidget().text(label: "Gender : "),
                  Expanded(child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 10),
                    child: MyWidget().textFormField2(align: TextAlign.right),
                  )),
                ],
              ),
              const Divider(color: Colors.transparent),
              Row(
                children: [
                  MyWidget().text(label: "Phone No. : "),
                  Expanded(child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 10),
                    child: MyWidget().textFormField2(align: TextAlign.right),
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
              MyWidget().textFormField2(),
              const SizedBox(height: 25),
              MyWidget().text(
                label: "Work Experience",
                weight: FontWeight.bold,
                size: 17,
              ),
              const SizedBox(height: 15),
              MyWidget().textFormField2(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: (){},
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
                          color: Colors.grey.shade700
                        )
                      ),
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
                        onPressed: (){
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
                          color: Colors.grey.shade700
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 50, preferredCameraDevice: CameraDevice.front
    );
    setState(() {
      imageFile = File(image!.path);
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.front
    );
    setState(() {
      imageFile = File(image!.path);
    });
  }
}