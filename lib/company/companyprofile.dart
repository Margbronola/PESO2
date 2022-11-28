// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/company/posthiring.dart';
import 'package:peso/company/updatecompany.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/datacacher.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/services/auth.dart';
import 'package:peso/splashscreen.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final Authentication _auth = Authentication();
  final DataCacher cacher = DataCacher.instance;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("PROFILE"),
        titleSpacing: 2,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                if (uid != null) ...{
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Company")
                        .doc(uid)
                        .snapshots(includeMetadataChanges: true),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !snapshot.hasError) {
                        final docs = snapshot.data!;
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              width: size.width,
                              height: size.height * .2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                                              Text("${docs.get("companyname")}",
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
                                          backgroundColor: Colors.grey.shade200,
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
                                                  child:
                                                      const UpdateCompanyPage(),
                                                  type:
                                                      PageTransitionType.fade));
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text("Update",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  letterSpacing: 1)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: MyWidget().text(
                                label: "Company Information",
                                size: 16,
                                letterSpacing: 2,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text("Telephone / Phone Number  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(
                                      child: Text(
                                    docs.get("Telephone") != null
                                        ? "${docs.get("Telephone")}"
                                        : "",
                                    textAlign: TextAlign.end,
                                  ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Map ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  docs.get("map") == null
                                      ? Container()
                                      : SizedBox(
                                          width: size.width,
                                          height: 200,
                                          child: Image.network(
                                            docs.get("map"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(top: 20),
                            //   child: MyWidget().text(
                            //     label: "Hiring",
                            //     size: 16,
                            //     letterSpacing: 2,
                            //     weight: FontWeight.bold,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 10, horizontal: 20),
                            //   child: StreamBuilder(
                            //     stream: FirebaseFirestore.instance
                            //         .collection("Company")
                            //         .doc(uid)
                            //         .collection("Hiring")
                            //         .snapshots(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData && !snapshot.hasError) {
                            //         final result = snapshot.data!;
                            //         return ListView.builder(
                            //           shrinkWrap: true,
                            //           physics:
                            //               const NeverScrollableScrollPhysics(),
                            //           padding: const EdgeInsets.all(0),
                            //           itemCount: result.size,
                            //           itemBuilder: (_, i) {
                            //             final available = result.docs[i];
                            //             return Container(
                            //               margin:
                            //                   const EdgeInsets.only(bottom: 5),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text(
                            //                       "${available.get("position")}"),
                            //                   MaterialButton(
                            //                     padding:
                            //                         const EdgeInsets.all(0),
                            //                     elevation: 0,
                            //                     onPressed: () {
                            //                       FirebaseFirestore.instance
                            //                           .collection('Company')
                            //                           .doc(uid)
                            //                           .collection('Hiring')
                            //                           .doc(available.id)
                            //                           .delete();
                            //                     },
                            //                     color: Colors.white,
                            //                     child: const Text(
                            //                       "COMPLETE",
                            //                       style: TextStyle(
                            //                         color: Colors.red,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             );
                            //           },
                            //         );
                            //       }
                            //       return const Text(
                            //         "No available hiring",
                            //         textAlign: TextAlign.center,
                            //       );
                            //     },
                            //   ),
                            // ),
                            // Container(
                            //   width: size.width,
                            //   height: 55,
                            //   margin: const EdgeInsets.only(top: 10),
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.shade300,
                            //         spreadRadius: 3,
                            //         blurRadius: 7,
                            //         offset: const Offset(0, 3),
                            //       ),
                            //     ],
                            //   ),
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       Navigator.pushReplacement(
                            //         context,
                            //         PageTransition(
                            //           child: PostHiringPage(
                            //             name:
                            //                 "${docs.get("firstname")}  ${docs.get("lastname")}",
                            //             email: "${docs.get("email")}",
                            //             image: "${docs.get("image")}",
                            //             address: "${docs.get("address")}",
                            //             telephone: "${docs.get("Telephone")}",
                            //             map: "${docs.get("map")}",
                            //           ),
                            //           type: PageTransitionType.fade,
                            //         ),
                            //       );
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: Colors.white,
                            //       shadowColor: Colors.transparent,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(20),
                            //       ),
                            //     ),
                            //     child: MyWidget().text(
                            //       label: "POST HIRING",
                            //       size: 20,
                            //       letterSpacing: 3,
                            //       weight: FontWeight.bold,
                            //       color: Colors.grey.shade700,
                            //     ),
                            //   ),
                            // ),
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
                  margin: const EdgeInsets.only(top: 40),
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
                      backgroundColor: Colors.red.shade800,
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
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isloading ? MyWidget().loader() : Container()
        ],
      ),
    );
  }
}
