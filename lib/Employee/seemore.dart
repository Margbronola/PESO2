// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeeMorePage extends StatefulWidget {
  String title;
  dynamic data;
  SeeMorePage({super.key, this.title = "", required this.data});

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
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * .07,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchString = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    hintText: 'Search job offer',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: double.maxFinite,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child:
                          const Icon(Icons.search_rounded, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            StreamBuilder(
                stream: (searchString != "" && searchString != null)
                    ? FirebaseFirestore.instance
                        .collection("JobOffer")
                        .where("position", isNotEqualTo: searchString)
                        .orderBy("position")
                        .startAt([
                        searchString,
                      ]).endAt([
                        searchString + '\uf8ff',
                      ]).snapshots()
                    : FirebaseFirestore.instance
                        .collection("JobOffer")
                        .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    return Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.red,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.data,
                // features.length < 3 ? features.length : 3,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     child: const JobDetailsPage(),
                      //     type: PageTransitionType.fade,
                      //   ),
                      // );
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
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.black12,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Company Name".toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: size.height * .009,
                                  ),
                                  const Text(
                                    "Company job vacancy",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
