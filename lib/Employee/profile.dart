import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/Employee/updateemployee.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/datacacher.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/services/auth.dart';
import 'package:peso/splashscreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  final Authentication _auth = Authentication();
  final DataCacher cacher = DataCacher.instance;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text("PROFILE"),
          titleSpacing: 2,
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: ListView(
                children: [
                  if (uid != null) ...{
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("User")
                          .doc(uid)
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !snapshot.hasError) {
                          final docs = snapshot.data!;
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              Container(
                                width: size.width,
                                height: size.height * .2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          child: Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            ),
                                            child: docs.get("image") == null
                                                ? const Center(
                                                    child: Icon(
                                                      Icons.person_outline,
                                                      size: 30,
                                                    ),
                                                  )
                                                : Image.network(
                                                    docs.get("image"),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${docs.get("firstname")} ${docs.get("lastname")}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                const SizedBox(height: 3),
                                                Text("${docs.get("email")}")
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                child: UpdateEmployeePage(
                                                  data: docs.data(),
                                                ),
                                                type: PageTransitionType.fade,
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                color: Colors.black45,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey.shade200,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 20),
                                child: MyWidget().text(
                                  label: "Personal Information",
                                  size: 16,
                                  letterSpacing: 2,
                                  weight: FontWeight.bold,
                                ),
                              ),

                              // /// PERSONAL INFORMATION
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Address ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("address") != null
                                              ? "${docs.get("address")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Birthday ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("birthday") != null
                                              ? "${docs.get("birthday")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Age ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("Age") != null
                                              ? "${docs.get("Age")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Civil Status ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("CivilStatus") != null
                                              ? "${docs.get("CivilStatus")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Gender ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("gender") != null
                                              ? "${docs.get("gender")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Phone Number ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("phoneNumber") != null
                                              ? "${docs.get("phoneNumber")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Religion ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("Religion") != null
                                              ? "${docs.get("Religion")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Desired Position ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("desiredPosition") != null
                                              ? "${docs.get("desiredPosition")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: MyWidget().text(
                                    label: "Educational Attainment",
                                    size: 16,
                                    letterSpacing: 2,
                                    weight: FontWeight.bold,
                                  )),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Elementary ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("Elementary") != null
                                              ? "${docs.get("Elementary")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("School Year",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("ElemSchoolYear") != null
                                              ? "${docs.get("ElemSchoolYear")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("High School",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                          docs.get("HighSchool") != null
                                              ? "${docs.get("HighSchool")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("School Year",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("HSSchoolYear") != null
                                              ? "${docs.get("HSSchoolYear")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("College",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("College") != null
                                              ? "${docs.get("College")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("School Year",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                            child: Text(
                                          docs.get("CollegeSchoolYear") != null
                                              ? "${docs.get("CollegeSchoolYear")}"
                                              : "",
                                          textAlign: TextAlign.end,
                                        ))
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: MyWidget().text(
                                    label: "Skills",
                                    size: 16,
                                    letterSpacing: 2,
                                    weight: FontWeight.bold,
                                  )),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  docs.get("skills") != null
                                      ? (docs.get("skills") as List).join("\n")
                                      : "",
                                ),
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 20),
                                  child: MyWidget().text(
                                    label: "Work Experience",
                                    size: 16,
                                    letterSpacing: 2,
                                    weight: FontWeight.bold,
                                  )),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  docs.get("experience") != null
                                      ? (docs.get("experience") as List)
                                          .join("\n")
                                      : "",
                                ),
                              ),
                            ],
                          );
                        }
                        return MyWidget().loader();
                      },
                    ),
                  },
                  Container(
                    width: size.width,
                    height: 55,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          await _auth.signout().whenComplete(() {
                            cacher.deleteToken();
                            setState(() {
                              isloading = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const SplashScreenPage(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: MyWidget().text(
                            label: "LOGOUT",
                            size: 20,
                            letterSpacing: 3,
                            weight: FontWeight.bold,
                            color: Colors.grey.shade700)),
                  )
                ],
              ),
            ),
            isloading ? MyWidget().loader() : Container()
          ],
        ),
      ),
    );
  }
}
