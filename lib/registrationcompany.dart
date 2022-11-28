// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/company/companylanding.dart';
import 'package:peso/login.dart';
import 'package:peso/services/auth.dart';

class CompanyRegistrationPage extends StatefulWidget {
  String type;
  CompanyRegistrationPage({super.key, this.type = ""});

  @override
  State<CompanyRegistrationPage> createState() =>
      _CompanyRegistrationPageState();
}

class _CompanyRegistrationPageState extends State<CompanyRegistrationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Authentication _auth = Authentication();
  bool isobsecure = false;
  bool isobsecure1 = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * .09,
                    ),
                    const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * .07,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.business,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Company Name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              labelText: "Company Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.email_rounded,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Email';
                              }

                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please enter a valid Email';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              labelText: "Email",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.key_rounded,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: password,
                            obscureText: !isobsecure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: "Password",
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isobsecure = !isobsecure;
                                      });
                                    },
                                    icon: Icon(
                                      isobsecure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.grey,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.key_rounded,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: confirmpassword,
                            obscureText: !isobsecure1,
                            validator: (value) {
                              if (password.text.isEmpty) {
                                if (value!.isEmpty) {
                                  return null;
                                }
                              } else {
                                if (value!.isEmpty) {
                                  return 'Retype Password';
                                }
                              }

                              if (password.text != confirmpassword.text) {
                                return 'Password didn\'t match';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: "Retype Password",
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isobsecure1 = !isobsecure1;
                                      });
                                    },
                                    icon: Icon(
                                      isobsecure1
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.grey,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 10, top: 40),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                              letterSpacing: 3,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });

                            await _auth
                                .createCompany(
                                    email: email.text,
                                    password: password.text,
                                    name: name.text,
                                    page: widget.type)
                                .then((value) {
                              if (value != null) {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const CompanyLandingPage(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              }
                            }).whenComplete(
                                    () => setState(() => isloading = false));
                          }
                        },
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(
                              color: Colors.black45, letterSpacing: 1.5),
                          children: [
                            TextSpan(
                              text: ' Login here.',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: LoginPage(page: widget.type),
                                          type: PageTransitionType.fade));
                                }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              isloading
                  ? Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.grey.withOpacity(.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
