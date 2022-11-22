import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/services/addHiring.dart';

class PostHiringPage extends StatefulWidget {
  String name;
  String email;
  String address;
  String telephone;
  String map;
  String image;

  PostHiringPage({
    super.key,
    required this.name,
    required this.email,
    required this.telephone,
    required this.address,
    required this.map,
    required this.image,
  });

  @override
  State<PostHiringPage> createState() => _PostHiringPageState();
}

class _PostHiringPageState extends State<PostHiringPage> {
  late final TextEditingController aboutTheJob;
  late final TextEditingController _qualification;
  late final TextEditingController position;
  bool isloading = false;

  @override
  void initState() {
    aboutTheJob = TextEditingController();
    _qualification = TextEditingController();
    position = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    aboutTheJob.dispose();
    _qualification.dispose();
    position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("HIRING"),
        titleSpacing: 2,
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyWidget().text(
                label: "Position",
                size: 16,
                letterSpacing: 2,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child:
                  MyWidget().textFormField2(maxline: 2, controller: position),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyWidget().text(
                label: "About the Job",
                size: 16,
                letterSpacing: 2,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: MyWidget()
                  .textFormField2(maxline: 5, controller: aboutTheJob),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyWidget().text(
                label: "Qualification",
                size: 16,
                letterSpacing: 2,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: MyWidget()
                  .textFormField2(maxline: 5, controller: _qualification),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        final List<String> qualification =
                            _qualification.text.split("\n");
                        setState(() {
                          isloading = true;
                        });
                        if (aboutTheJob.text.isEmpty &&
                            _qualification.text.isEmpty &&
                            position.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Fill all fields");
                          setState(() {
                            isloading = false;
                          });
                        } else {
                          Hiring().add(uid, position.text, aboutTheJob.text,
                              qualification);

                          Hiring()
                              .addjobOffer(
                                  uid.toString(),
                                  widget.name,
                                  widget.email,
                                  widget.image,
                                  widget.address,
                                  widget.telephone,
                                  position.text,
                                  aboutTheJob.text,
                                  widget.map,
                                  qualification)
                              .whenComplete(() {
                            setState(() {
                              isloading = false;
                            });
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: MyWidget().text(
                        label: "SAVE",
                        letterSpacing: 2,
                        weight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: 55,
                    margin: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: MyWidget().text(
                            label: "CANCEL",
                            letterSpacing: 2,
                            weight: FontWeight.bold,
                            color: Colors.grey.shade700)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
