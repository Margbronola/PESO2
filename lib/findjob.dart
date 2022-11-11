import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/form.dart';
import 'package:peso/global/datacacher.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/login.dart';
import 'package:peso/services/auth.dart';

class FindJobPage extends StatefulWidget {
  const FindJobPage({super.key});

  @override
  State<FindJobPage> createState() => _FindJobPageState();
}

class _FindJobPageState extends State<FindJobPage> {
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  final Authentication _auth = Authentication();
  final DataCacher cacher = DataCacher.instance;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text("PROFILE"),
          titleSpacing: 2,
        ),
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: const Center(
                                child: Icon(
                                  Icons.person_outline,
                                  size: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("First Name + Last Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text("Email")
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const FormPage(),
                                        type: PageTransitionType.fade));
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text("Update",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        letterSpacing: 1)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: MyWidget().text(
                        label: "Personal Information",
                        size: 16,
                        letterSpacing: 2,
                        weight: FontWeight.bold,
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: MyWidget().text(
                        label: "Skills",
                        size: 16,
                        letterSpacing: 2,
                        weight: FontWeight.bold,
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: MyWidget().text(
                        label: "Work Experience",
                        size: 16,
                        letterSpacing: 2,
                        weight: FontWeight.bold,
                      )),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: const EdgeInsets.only(top: 40),
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
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          await _auth.signout().whenComplete(() {
                            cacher.deleteToken();
                            setState(() {
                              isloading = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const LoginPage(),
                                type: PageTransitionType.fade,
                              ),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: MyWidget().text(
                            label: "LOGOUT",
                            size: 20,
                            letterSpacing: 3,
                            weight: FontWeight.bold,
                            color: Colors.grey.shade700)),
                  )
                ],
              ),
            ),
            isloading ? MyWidget().loader() : Container()
          ],
        ),
      ),
    );
  }
}
