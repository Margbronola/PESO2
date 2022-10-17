import 'package:flutter/material.dart';
import 'package:peso/global/widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
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
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView(
            children: [
              MyWidget().text(
                label: "Personal Information",
                weight: FontWeight.bold,
                size: 17,
              ),
              const SizedBox(height: 15),
              MyWidget().text(label: "Address : "),
              MyWidget().textFormField2(),
              const Divider(color: Colors.transparent),
              Row(
                children: [
                  MyWidget().text(label: "Birthday : "),
                  Expanded(child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 10),
                    child: MyWidget().textFormField2(),
                  )),
                ],
              ),
              const Divider(color: Colors.transparent),
              Row(
                children: [
                  MyWidget().text(label: "Gender : "),
                  Expanded(child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 10),
                    child: MyWidget().textFormField2(),
                  )),
                ],
              ),
              const Divider(color: Colors.transparent),
              Row(
                children: [
                  MyWidget().text(label: "Phone No. : "),
                  Expanded(child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 10),
                    child: MyWidget().textFormField2(),
                  )),
                ],
              ),
              const SizedBox(height: 25),
              MyWidget().text(
                label: "Skills",
                weight: FontWeight.bold,
                size: 17,
              ),
              const SizedBox(height: 15),
              MyWidget().textFormField2(),
              const SizedBox(height: 25),
              MyWidget().text(
                label: "Work Experience",
                weight: FontWeight.bold,
                size: 17,
              ),
              const SizedBox(height: 15),
              MyWidget().textFormField2(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      child: ElevatedButton(
                        onPressed: (){},
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
                          color: Colors.grey.shade700
                        )
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      child: ElevatedButton(
                        onPressed: (){
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
                          color: Colors.grey.shade700
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}