import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/company/companyprofile.dart';
import 'package:peso/company/compjobdetails.dart';
import 'package:peso/company/posthiring.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';

class CompanyLandingPage extends StatefulWidget {
  const CompanyLandingPage({super.key});

  @override
  State<CompanyLandingPage> createState() => _CompanyLandingPageState();
}

class _CompanyLandingPageState extends State<CompanyLandingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 20, top: 7, bottom: 7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const CompanyProfilePage(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
              icon: const Icon(Icons.person_rounded),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Company")
              .doc(uid)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              final docs = snapshot.data!;
              return ListView(
                children: [
                  Container(
                    width: size.width,
                    height: 55,
                    margin: const EdgeInsets.only(top: 10),
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
                      onPressed: () {
                        if (docs.get("address") == null ||
                            docs.get("image") == null ||
                            docs.get("Telephone") == null ||
                            docs.get("map") == null) {
                          Fluttertoast.showToast(
                              msg: "Update Company details to post hiring");
                        } else {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: PostHiringPage(
                                name: "${docs.get("companyname")}",
                                email: "${docs.get("email")}",
                                image: "${docs.get("image")}",
                                address: "${docs.get("address")}",
                                telephone: "${docs.get("Telephone")}",
                                map: "${docs.get("map")}",
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: MyWidget().text(
                        label: "POST HIRING",
                        size: 20,
                        letterSpacing: 3,
                        weight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("JobOffer")
                            .where("uid", isEqualTo: uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !snapshot.hasError) {
                            final result = snapshot.data!;
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: result.size,
                              itemBuilder: (_, i) {
                                final available = result.docs[i];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: CompanyJobDetails(
                                              data: available.data(),
                                              hiringid: available.id,
                                            ),
                                            type: PageTransitionType.fade));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      "${available.get("position")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(color: Colors.grey),
                            );
                          }
                          return const Text(
                            "No available hiring",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            return MyWidget().loader();
          },
        ),
      ),
    );
  }
}
