import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/landing.dart';
import 'package:peso/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white) 
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.person_rounded, color: Colors.blue.shade400),
                    hintText: "Email",
                  ),
                )
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: password,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white) 
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.key_rounded, color: Colors.blue.shade400),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: (){ 
                        setState(() {
                          _isObscured =! _isObscured;
                        });
                      },
                      icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                    )
                  ),
                )
              ),
              SizedBox(
                width: size.width,
                height: 50,
                child: ElevatedButton(
                  child: const Text("LOGIN",
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                  ), 
                  onPressed: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const WelcomePage(),
                        type: PageTransitionType.fade
                      )
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}