import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/company/employeedetails.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';

class CompanyJobDetails extends StatefulWidget {
  dynamic data;
  String hiringid;
  CompanyJobDetails({super.key, required this.data, required this.hiringid});

  @override
  State<CompanyJobDetails> createState() => _CompanyJobDetailsState();
}

class _CompanyJobDetailsState extends State<CompanyJobDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade100,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: ListView(
          children: [
            Text(
              "${widget.data['position']}".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "${widget.data['description']}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Qualification",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "${widget.data['qualification'].join("\n")}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 55,
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                elevation: 0,
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Company')
                      .doc(uid)
                      .collection('Hiring')
                      .doc(widget.hiringid)
                      .delete();
                  FirebaseFirestore.instance
                      .collection('JobOffer')
                      .doc(widget.hiringid)
                      .delete();
                  Navigator.of(context).pop();
                },
                color: Colors.black,
                child: const Text(
                  "COMPLETE",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: MyWidget().text(
                label: "Interested Applicants",
                size: 20,
                letterSpacing: 2,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: size.width,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Applicant")
                    .where("companyid", isEqualTo: uid)
                    .where("jobId", isEqualTo: widget.hiringid)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    final result = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: result.size,
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
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.grey.shade200,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  child: Container(
                                    width: 60,
                                    height: 60,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
