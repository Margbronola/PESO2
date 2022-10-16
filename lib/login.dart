import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/registration.dart';
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
          color: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                color: Colors.black12,
                margin: const EdgeInsets.only(bottom: 40),
                alignment: Alignment.center,
                child: const Text("LOGO"),
              ),

              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white) ,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.person_rounded, color: Colors.black87),
                    hintText: "Email",
                  ),
                )
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 30),
                child: TextFormField(
                  controller: password,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.key_rounded, color: Colors.black87),
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: (){ 
                        setState(() {
                          _isObscured =! _isObscured;
                        });
                      },
                      icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.grey.shade400,),
                    )
                  ),
                )
              ),

              Container(
                width: size.width,
                height: 50,
                margin: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: const Text("LOGIN",
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
                        child: const WelcomePage(),
                        type: PageTransitionType.fade
                      )
                    );
                  },
                ),
              ),

              RichText(
                text: TextSpan(
                  text: 'Dont have an account? ',
                    style: const TextStyle(
                      color: Colors.black45,
                      letterSpacing: 1.5
                    ),
                  children: [
                    TextSpan(
                      text: ' Register here.',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = (() {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const RegistrationPage(),
                            type: PageTransitionType.fade
                          )
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}