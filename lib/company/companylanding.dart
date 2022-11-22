import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/company/companyprofile.dart';
import 'package:peso/company/employeedetails.dart';
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
              .collection("Applicant")
              .where("companyid", isEqualTo: uid)
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.hasError) {
              final result = snapshot.data!;
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: MyWidget().text(
                      label: "Interested Applicants",
                      size: 20,
                      letterSpacing: 2,
                      weight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: result.size < 3 ? result.size : 3,
                    itemBuilder: (BuildContext ctx, int index) {
                      final docs = result.docs[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: EmployeeDetailsPage(
                                data: docs.data(),
                              ),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        child: Container(
                          width: size.width,
                          height: size.height * .15,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.shade100,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.black12,
                                  child: docs.get("image") == null
                                      ? const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                          ),
                                        )
                                      : Image.network(
                                          docs.get("image"),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${docs.get("firstname")} ${docs.get("lastname")}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${docs.get("email")}",
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
