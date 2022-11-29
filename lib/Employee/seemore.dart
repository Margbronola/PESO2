// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/Employee/jobdetails.dart';

class SeeMorePage extends StatefulWidget {
  String title;
  String desiredPosition;
  SeeMorePage({
    super.key,
    this.title = "",
    this.desiredPosition = "",
  });

  @override
  State<SeeMorePage> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends State<SeeMorePage> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.title.toUpperCase()),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: ListView(
          children: [
            // Container(
            //   width: size.width,
            //   height: size.height * .07,
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   margin: const EdgeInsets.symmetric(vertical: 5),
            //   alignment: Alignment.center,
            //   child: Expanded(
            //     child: TextField(
            //       onChanged: (value) {
            //         setState(() {
            //           searchString = value.toLowerCase();
            //         });
            //       },
            //       decoration: InputDecoration(
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey.shade300),
            //           borderRadius: const BorderRadius.all(Radius.circular(15)),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey.shade300),
            //           borderRadius: const BorderRadius.all(Radius.circular(15)),
            //         ),
            //         hintText: 'Search job offer',
            //         hintStyle: const TextStyle(color: Colors.grey),
            //         filled: true,
            //         fillColor: Colors.white,
            //         suffixIconConstraints: const BoxConstraints(
            //           maxHeight: double.maxFinite,
            //         ),
            //         suffixIcon: Container(
            //           margin: const EdgeInsets.only(right: 10),
            //           decoration: const BoxDecoration(
            //             color: Colors.white,
            //           ),
            //           child:
            //               const Icon(Icons.search_rounded, color: Colors.grey),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 15),
            StreamBuilder(
              stream: widget.title == "Popular Jobs"
                  ? FirebaseFirestore.instance
                      .collection("JobOffer")
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("JobOffer")
                      .where("position", isEqualTo: "${widget.desiredPosition}")
                      .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  final result = snapshot.data;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: result!.size,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (BuildContext ctx, int index) {
                      final doc = result.docs[index];
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.shade100,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.black12,
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
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        doc.get("companyName").toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: size.height * .009,
                                      ),
                                      Text(
                                        doc.get("position"),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
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
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
