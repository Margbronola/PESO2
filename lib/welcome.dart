import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/landing.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://i.blogs.es/b4dd5c/maps/1366_2000.png"), 
                fit: BoxFit.cover,
                opacity: .7
              )
            ),
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * .2,
                ),

                Container(
                  color: Colors.grey.shade300,
                  width: 200,
                  height: 200,
                ),

                SizedBox(
                  height: size.height *.4,
                ),

                SizedBox(
                width: size.width,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(15)
                    ), 
                    backgroundColor: const Color.fromARGB(255, 27, 80, 212)
                  ),

                  child: const Text("GET STARTED",
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                  ), 
                  onPressed: (){
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const LandingPage(),
                        type: PageTransitionType.fade
                      )
                    );
                  },
                ),
              )
              ],
            ),
          )
        ],
      ),
    );
  }
}