import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/global/widget.dart';
import 'package:peso/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('CREATE ACCOUNT'),
          // titleTextStyle: const TextStyle(
          //   color: Colors.black,
          //   fontWeight: FontWeight.bold,
          //   letterSpacing: 1.5
          // ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              SizedBox(
                height: size.height *.08,
              ),

              const Text("CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: size.height *.12,
              ),
    
              Row(
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: MyWidget().textFormField(
                        label: "First Name",
                        controller: fname,
                        inputType: TextInputType.name,
                        obscurity: false
                      )
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height *.01,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: MyWidget().textFormField(
                        label: "Last Name",
                        controller: lname,
                        inputType: TextInputType.name,
                        obscurity: false
                      )
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height *.01,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.email_rounded,
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: MyWidget().textFormField(
                        label: "Email",
                        controller: email,
                        inputType: TextInputType.emailAddress,
                        obscurity: false
                      )
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height *.01,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.key_rounded,
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: MyWidget().textFormField(
                        label: "Password",
                        controller: password,
                        inputType: TextInputType.text,
                        obscurity: true
                      )
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height *.01,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.key_rounded,
                    color: Colors.black87,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      child: MyWidget().textFormField(
                        label: "Confirm Password",
                        controller: confirmpassword,
                        inputType: TextInputType.text,
                        obscurity: true
                      )
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
                    backgroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: const Text("REGISTER",
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ), 
                  onPressed: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const LoginPage(),
                        type: PageTransitionType.fade
                      )
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}