// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class EmployeeDetailsPage extends StatefulWidget {
  dynamic data;
  EmployeeDetailsPage({super.key, required this.data});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  // sendSMS() async {
  //   String message = "This is a test message!";
  //   List<String> recipents = ["1234567890", "5556787676"];

  //   String _result =
  //       await sendSMS(message: message, recipients: recipents, sendDirect: true)
  //           .catchError((onError) {
  //     print(onError);
  //   });
  //   print(_result);
  // }

  void sendingSMS(String msg, List<String> listReceipents) async {
    String sendResult = await sendSMS(message: msg, recipients: listReceipents)
        .catchError((err) {
      print("ERROR: $err");
    });
    print(sendResult);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("EMPLOYEE DETAILS"),
        titleSpacing: 2,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade100,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Container(
              width: size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                        "${widget.data['firstname']} ${widget.data['lastname']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.data['email']}",
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
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
                    "Personal Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Address ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              widget.data["address"] != null
                                  ? "${widget.data["address"]}"
                                  : "",
                              textAlign: TextAlign.end,
                            ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Birthday ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              widget.data["birthday"] != null
                                  ? "${widget.data["birthday"]}"
                                  : "",
                              textAlign: TextAlign.end,
                            ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Gender ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              widget.data["gender"] != null
                                  ? "${widget.data["gender"]}"
                                  : "",
                              textAlign: TextAlign.end,
                            ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Phone Number ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              widget.data["phoneNumber"] != null
                                  ? "${widget.data["phoneNumber"]}"
                                  : "",
                              textAlign: TextAlign.end,
                            ))
                          ],
                        ),
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
                    "Skills",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.data["skills"] != null
                          ? (widget.data["skills"] as List).join("\n")
                          : "",
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
                    "Work Experience",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.data["experience"] != null
                          ? (widget.data["experience"] as List).join("\n")
                          : "",
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700),
                child: const Text(
                  "Interested",
                  style: TextStyle(letterSpacing: 2, fontSize: 18),
                ),
                onPressed: () {
                  sendingSMS(
                    "We are interested on your application \n Management",
                    ["${widget.data["phoneNumber"]}"],
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
