import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peso/global/container.dart';
import 'package:peso/services/applicant.dart';

class JobDetailsPage extends StatefulWidget {
  String jobId;
  dynamic data;
  JobDetailsPage({super.key, required this.data, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Text(
              "${widget.data['position']}".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: widget.data['image'] == null
                          ? const Center(
                              child: Icon(
                                Icons.business_outlined,
                                size: 50,
                              ),
                            )
                          : Image.network(
                              widget.data['image'],
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data['companyName']}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.data['email']}",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.data['description']}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${widget.data['qualification'].join("\n")}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Company Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Telephone / Phone No. ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.data['telephone']}",
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Address ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(
                            "${widget.data['address']}",
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Map ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        widget.data['map'] == null
                            ? Container()
                            : SizedBox(
                                width: size.width,
                                height: 200,
                                child: Image.network(
                                  widget.data['map'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .doc(uid)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                final result = snapshot.data!;
                return SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700),
                    child: const Text(
                      "APPLY",
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Applicant().apply(
                        widget.data['uid'],
                        result.get("firstname"),
                        result.get("lastname"),
                        result.get("email"),
                        result.get("image"),
                        result.get("address"),
                        result.get("phoneNumber"),
                        result.get("gender"),
                        result.get("birthday"),
                        widget.jobId,
                        result.get("skills"),
                        result.get("experience"),
                        result.get("desiredPosition"),
                        result.get("Elementary"),
                        result.get("ElemSchoolYear"),
                        result.get("HighSchool"),
                        result.get("HSSchoolYear"),
                        result.get("College") ?? null,
                        result.get("CollegeSchoolYear") ?? null,
                        result.get("Religion"),
                        result.get("Age"),
                        result.get("CivilStatus"),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
