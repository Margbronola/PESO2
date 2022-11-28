// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/Employee/profile.dart';
import 'package:peso/Employee/jobdetails.dart';
import 'package:peso/Employee/seemore.dart';
import 'package:peso/global/container.dart';

class EmployeeLandingPage extends StatefulWidget {
  const EmployeeLandingPage({Key? key}) : super(key: key);

  @override
  State<EmployeeLandingPage> createState() => _EmployeeLandingPageState();
}

class _EmployeeLandingPageState extends State<EmployeeLandingPage> {
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
                    child: const ProfilePage(),
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
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  final user = snapshot.data!;
                  return Container(
                    width: size.width,
                    height: size.height * .22,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Suggested Jobs",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: SeeMorePage(
                                      title: "Suggested Jobs",
                                      desiredPosition:
                                          "${user.get("desiredPosition")}",
                                    ),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                              child: Text(
                                "See more",
                                style: TextStyle(
                                  letterSpacing: .5,
                                  fontSize: 16,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("JobOffer")
                                .where("position",
                                    isEqualTo: "${user.get("desiredPosition")}")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !snapshot.hasError) {
                                final results = snapshot.data!;
                                print(results.size);
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      results.size < 5 ? results.size : 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    final docs = results.docs[index];

                                    return Container(
                                      width: size.width * .6,
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: JobDetailsPage(
                                                data: docs.data(),
                                                jobId: docs.id,
                                              ),
                                              type: PageTransitionType.fade,
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                          Icons
                                                              .business_outlined,
                                                          size: 50,
                                                        ),
                                                      )
                                                    : Image.network(
                                                        docs.get("image"),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${docs.get("companyName")}"
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * .009,
                                                    ),
                                                    Text(
                                                      "${docs.get("position")}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("JobOffer")
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && !snapshot.hasError) {
                      final result = snapshot.data!;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Popular Jobs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: SeeMorePage(
                                        title: "Popular Jobs",
                                      ),
                                      type: PageTransitionType.fade,
                                    ),
                                  );
                                },
                                child: Text(
                                  "See more",
                                  style: TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: result.size < 5 ? result.size : 5,
                                itemBuilder: (BuildContext ctx, int x) {
                                  final doc = result.docs[x];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          child: JobDetailsPage(
                                            data: doc.data(),
                                            jobId: doc.id,
                                          ),
                                          type: PageTransitionType.fade,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: size.height * .15,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.grey.shade100,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: doc.get("image") == null
                                                  ? const Center(
                                                      child: Icon(
                                                        Icons.business_outlined,
                                                        size: 50,
                                                      ),
                                                    )
                                                  : Image.network(
                                                      doc.get("image"),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${doc.get("companyName")}"
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: size.height * .009,
                                                  ),
                                                  Text(
                                                    "${doc.get("position")}",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(
                      child: Text(
                        "No available Job Hiring",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
