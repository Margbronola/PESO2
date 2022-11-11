import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/employeedetails.dart';
import 'package:peso/findemployee.dart';

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
                          child: const FindEmployeePage(),
                          type: PageTransitionType.fade));
                },
                icon: const Icon(Icons.person_rounded)),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemCount: 7,
          // features.length < 3 ? features.length : 3,
          itemBuilder: (BuildContext ctx, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const EmployeeDetailsPage(),
                        type: PageTransitionType.fade));
              },
              child: Container(
                width: size.width,
                height: size.height * .15,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.grey.shade100,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
    );
  }
}
